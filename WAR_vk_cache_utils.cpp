/* Workaround for vk_cache_utils.cpp
 * J: https://zenn.dev/okuoku/scraps/f46dd5fc142bd0 */

#include "libANGLE/renderer/vulkan/vk_cache_utils.h"
 
#include "common/aligned_memory.h"
#include "common/system_utils.h"
#include "libANGLE/BlobCache.h"
#include "libANGLE/VertexAttribute.h"
#include "libANGLE/renderer/vulkan/DisplayVk.h"
#include "libANGLE/renderer/vulkan/FramebufferVk.h"
#include "libANGLE/renderer/vulkan/ProgramVk.h"
#include "libANGLE/renderer/vulkan/TextureVk.h"
#include "libANGLE/renderer/vulkan/VertexArrayVk.h"
#include "libANGLE/renderer/vulkan/vk_format_utils.h"
#include "libANGLE/renderer/vulkan/vk_helpers.h"
#include "libANGLE/renderer/vulkan/vk_renderer.h"
 
#include <type_traits>


/* Explicitly instantiate template functions */
namespace rx {
    /* Copied from vk_cache_utils.cpp */
    //
    // Copyright 2018 The ANGLE Project Authors. All rights reserved.
    // Use of this source code is governed by a BSD-style license that can be
    // found in the LICENSE file.
    //

    template <typename T>
        T *UpdateDescriptorSetsBuilder::DescriptorInfoAllocator<T>::allocate(uint32_t count)
        {
            size_t oldSize = mCurrentVector->size();
            size_t newSize = oldSize + count;
            if (newSize <= mCurrentVector->capacity())
            {
                (*mCurrentVector).resize(newSize);
                mTotalSize += count;
                return &(*mCurrentVector)[oldSize];
            }

            ++mCurrentVector;
            // clear() always ensures we have a single element left.
            ASSERT(mCurrentVector == mDescriptorInfos.end());

            // We have reached capacity, grow the storage
            mVectorCapacity = std::max(count, mVectorCapacity);
            mDescriptorInfos.emplace_back();
            mDescriptorInfos.back().reserve(mVectorCapacity);
            mCurrentVector = mDescriptorInfos.end() - 1;

            mCurrentVector->resize(count);
            mTotalSize += count;

            return &mCurrentVector->front();
        }

    template VkBufferView* UpdateDescriptorSetsBuilder::DescriptorInfoAllocator<VkBufferView>::allocate(uint32_t);
    template VkWriteDescriptorSet* UpdateDescriptorSetsBuilder::DescriptorInfoAllocator<VkWriteDescriptorSet>::allocate(uint32_t);
    template VkDescriptorImageInfo* UpdateDescriptorSetsBuilder::DescriptorInfoAllocator<VkDescriptorImageInfo>::allocate(uint32_t);
}
