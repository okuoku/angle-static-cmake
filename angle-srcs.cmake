set(angle_fe_translator_srcs
    # Common translator (instatiates implementation)
    src/compiler/translator/ShaderLang.cpp
    src/compiler/translator/ShaderVars.cpp)

set(angle_fe_preprocessor_srcs
    src/compiler/preprocessor/DiagnosticsBase.cpp
    src/compiler/preprocessor/DirectiveHandlerBase.cpp
    src/compiler/preprocessor/DirectiveParser.cpp
    src/compiler/preprocessor/ExpressionParser.cpp
    src/compiler/preprocessor/Input.cpp
    src/compiler/preprocessor/Lexer.cpp
    src/compiler/preprocessor/Macro.cpp
    src/compiler/preprocessor/MacroExpander.cpp
    src/compiler/preprocessor/Preprocessor.cpp
    src/compiler/preprocessor/Token.cpp
    src/compiler/preprocessor/Tokenizer.cpp)

set(angle_fe_translator_lib_srcs
    # FIXME: Separate into backends (HLSL/Vulkan/...)
    src/compiler/translator/tree_ops/AddAndTrueToLoopCondition.cpp
    src/compiler/translator/tree_ops/BreakVariableAliasingInInnerLoops.cpp
    src/compiler/translator/tree_ops/ClampFragDepth.cpp
    src/compiler/translator/tree_ops/ClampPointSize.cpp
    src/compiler/translator/tree_ops/DeclareAndInitBuiltinsForInstancedMultiview.cpp
    src/compiler/translator/tree_ops/DeferGlobalInitializers.cpp
    src/compiler/translator/tree_ops/EmulateGLFragColorBroadcast.cpp
    src/compiler/translator/tree_ops/EmulatePrecision.cpp
    src/compiler/translator/tree_ops/ExpandIntegerPowExpressions.cpp
    src/compiler/translator/tree_ops/FoldExpressions.cpp
    src/compiler/translator/tree_ops/InitializeVariables.cpp
    src/compiler/translator/tree_ops/PruneEmptyCases.cpp
    src/compiler/translator/tree_ops/PruneNoOps.cpp
    src/compiler/translator/tree_ops/RecordConstantPrecision.cpp
    src/compiler/translator/tree_ops/RegenerateStructNames.cpp
    src/compiler/translator/tree_ops/RemoveArrayLengthMethod.cpp
    src/compiler/translator/tree_ops/RemoveInvariantDeclaration.cpp
    src/compiler/translator/tree_ops/RemovePow.cpp
    src/compiler/translator/tree_ops/RemoveUnreferencedVariables.cpp
    src/compiler/translator/tree_ops/RewriteDoWhile.cpp
    src/compiler/translator/tree_ops/RewriteTexelFetchOffset.cpp
    src/compiler/translator/tree_ops/RewriteUnaryMinusOperatorFloat.cpp
    src/compiler/translator/tree_ops/RewriteUnaryMinusOperatorInt.cpp
    src/compiler/translator/tree_ops/ScalarizeVecAndMatConstructorArgs.cpp
    src/compiler/translator/tree_ops/SeparateDeclarations.cpp
    src/compiler/translator/tree_ops/SimplifyLoopConditions.cpp
    src/compiler/translator/tree_ops/SplitSequenceOperator.cpp
    src/compiler/translator/tree_ops/UnfoldShortCircuitAST.cpp
    src/compiler/translator/tree_ops/UseInterfaceBlockFields.cpp
    src/compiler/translator/tree_ops/VectorizeVectorScalarArithmetic.cpp

    src/compiler/translator/tree_util/FindMain.cpp
    src/compiler/translator/tree_util/FindSymbolNode.cpp
    src/compiler/translator/tree_util/IntermNodePatternMatcher.cpp
    src/compiler/translator/tree_util/IntermNode_util.cpp
    src/compiler/translator/tree_util/IntermTraverse.cpp
    src/compiler/translator/tree_util/ReplaceVariable.cpp
    src/compiler/translator/tree_util/RunAtTheEndOfShader.cpp

    # HLSL tree_ops
    src/compiler/translator/tree_ops/AddDefaultReturnStatements.cpp
    src/compiler/translator/tree_ops/ArrayReturnValueToOutParameter.cpp
    src/compiler/translator/tree_ops/RemoveDynamicIndexing.cpp
    src/compiler/translator/tree_ops/RemoveSwitchFallThrough.cpp
    src/compiler/translator/tree_ops/RewriteElseBlocks.cpp
    src/compiler/translator/tree_ops/SeparateArrayConstructorStatements.cpp
    src/compiler/translator/tree_ops/SeparateArrayInitialization.cpp
    src/compiler/translator/tree_ops/SeparateExpressionsReturningArrays.cpp
    src/compiler/translator/tree_ops/UnfoldShortCircuitToIf.cpp
    src/compiler/translator/tree_ops/WrapSwitchStatementsInBlocks.cpp

    # HLSL Sources
    src/compiler/translator/ASTMetadataHLSL.cpp
    src/compiler/translator/blocklayoutHLSL.cpp
    src/compiler/translator/BuiltInFunctionEmulatorHLSL.cpp
    src/compiler/translator/OutputHLSL.cpp
    src/compiler/translator/StructureHLSL.cpp
    src/compiler/translator/TextureFunctionHLSL.cpp
    src/compiler/translator/ImageFunctionHLSL.cpp
    src/compiler/translator/TranslatorHLSL.cpp
    src/compiler/translator/UniformHLSL.cpp
    src/compiler/translator/UtilsHLSL.cpp
    src/compiler/translator/emulated_builtin_functions_hlsl_autogen.cpp


    src/compiler/translator/blocklayout.cpp
    src/compiler/translator/glslang_lex.cpp
    src/compiler/translator/glslang_tab.cpp
    src/compiler/translator/util.cpp

    src/compiler/translator/BuiltInFunctionEmulator.cpp
    #src/compiler/translator/BuiltInFunctionEmulatorGLSL.cpp
    src/compiler/translator/CallDAG.cpp
    src/compiler/translator/CodeGen.cpp
    src/compiler/translator/CollectVariables.cpp
    src/compiler/translator/Compiler.cpp
    src/compiler/translator/ConstantUnion.cpp
    src/compiler/translator/Declarator.cpp
    src/compiler/translator/Diagnostics.cpp
    src/compiler/translator/DirectiveHandler.cpp
    src/compiler/translator/ExtensionBehavior.cpp
    #src/compiler/translator/ExtensionGLSL.cpp
    src/compiler/translator/FlagStd140Structs.cpp
    src/compiler/translator/FunctionLookup.cpp
    src/compiler/translator/HashNames.cpp
    src/compiler/translator/ImmutableString.cpp
    src/compiler/translator/ImmutableStringBuilder.cpp
    src/compiler/translator/InfoSink.cpp
    src/compiler/translator/Initialize.cpp
    src/compiler/translator/InitializeDll.cpp
    src/compiler/translator/IntermNode.cpp
    src/compiler/translator/IsASTDepthBelowLimit.cpp
    src/compiler/translator/Operator.cpp
    #src/compiler/translator/OutputESSL.cpp
    #src/compiler/translator/OutputGLSL.cpp
    #src/compiler/translator/OutputGLSLBase.cpp
    src/compiler/translator/OutputTree.cpp
    #src/compiler/translator/OutputVulkanGLSL.cpp
    src/compiler/translator/ParseContext.cpp
    src/compiler/translator/PoolAlloc.cpp
    src/compiler/translator/QualifierTypes.cpp
    src/compiler/translator/ShaderLang.cpp
    src/compiler/translator/ShaderVars.cpp
    src/compiler/translator/Symbol.cpp
    src/compiler/translator/SymbolTable.cpp
    src/compiler/translator/SymbolTable_autogen.cpp
    src/compiler/translator/SymbolUniqueId.cpp
    #src/compiler/translator/TranslatorESSL.cpp
    #src/compiler/translator/TranslatorGLSL.cpp
    #src/compiler/translator/TranslatorVulkan.cpp
    src/compiler/translator/Types.cpp
    src/compiler/translator/ValidateGlobalInitializer.cpp
    src/compiler/translator/ValidateLimitations.cpp
    src/compiler/translator/ValidateMaxParameters.cpp
    #src/compiler/translator/ValidateMultiviewWebGL.cpp
    src/compiler/translator/ValidateOutputs.cpp
    src/compiler/translator/ValidateSwitch.cpp
    src/compiler/translator/ValidateVaryingLocations.cpp
    src/compiler/translator/VariablePacker.cpp
    #src/compiler/translator/VersionGLSL.cpp
    src/third_party/compiler/ArrayBoundsClamper.cpp
    )

set(angle_common_srcs
    src/common/Float16ToFloat32.cpp
    src/common/MemoryBuffer.cpp
    src/common/aligned_memory.cpp
    src/common/angleutils.cpp
    src/common/debug.cpp
    src/common/mathutil.cpp
    src/common/matrix_utils.cpp
    src/common/string_utils.cpp
    src/common/system_utils.cpp
    src/common/third_party/base/anglebase/sha1.cc
    src/common/third_party/smhasher/src/PMurHash.cpp
    src/common/tls.cpp
    src/common/uniform_type_info_autogen.cpp
    src/common/utilities.cpp)

set(angle_common_win_srcs
    src/common/system_utils_win.cpp
    )

set(angle_libangle_srcs
    src/common/event_tracer.cpp # only for ANGLE?
    src/libANGLE/angletypes.cpp
    src/libANGLE/es3_copy_conversion_table_autogen.cpp
    src/libANGLE/format_map_autogen.cpp
    src/libANGLE/formatutils.cpp
    src/libANGLE/params.cpp
    src/libANGLE/queryconversions.cpp
    src/libANGLE/queryutils.cpp

    src/libANGLE/AttributeMap.cpp
    src/libANGLE/Buffer.cpp
    src/libANGLE/Caps.cpp
    src/libANGLE/Compiler.cpp
    src/libANGLE/Config.cpp
    src/libANGLE/Context.cpp
    src/libANGLE/Context_gles_1_0.cpp
    src/libANGLE/ContextState.cpp
    src/libANGLE/Debug.cpp
    src/libANGLE/Device.cpp
    src/libANGLE/Display.cpp
    src/libANGLE/Error.cpp
    src/libANGLE/Fence.cpp
    src/libANGLE/Framebuffer.cpp
    src/libANGLE/FramebufferAttachment.cpp
    src/libANGLE/GLES1State.cpp
    src/libANGLE/HandleAllocator.cpp
    src/libANGLE/HandleRangeAllocator.cpp
    src/libANGLE/Image.cpp
    src/libANGLE/ImageIndex.cpp
    src/libANGLE/IndexRangeCache.cpp
    src/libANGLE/LoggingAnnotator.cpp
    src/libANGLE/MemoryProgramCache.cpp
    src/libANGLE/Observer.cpp
    src/libANGLE/PackedGLEnums.cpp
    src/libANGLE/PackedGLEnums_autogen.cpp
    src/libANGLE/Path.cpp
    src/libANGLE/Platform.cpp
    src/libANGLE/Program.cpp
    src/libANGLE/ProgramLinkedResources.cpp
    src/libANGLE/ProgramPipeline.cpp
    src/libANGLE/Query.cpp
    src/libANGLE/Renderbuffer.cpp
    src/libANGLE/ResourceManager.cpp
    src/libANGLE/Sampler.cpp
    src/libANGLE/Shader.cpp
    src/libANGLE/State.cpp
    src/libANGLE/Stream.cpp
    src/libANGLE/Surface.cpp
    src/libANGLE/Texture.cpp
    src/libANGLE/Thread.cpp
    src/libANGLE/TransformFeedback.cpp
    src/libANGLE/Uniform.cpp
    src/libANGLE/VaryingPacking.cpp
    src/libANGLE/VertexArray.cpp
    src/libANGLE/VertexAttribute.cpp
    src/libANGLE/WorkerThread.cpp

    src/libANGLE/renderer/ContextImpl.cpp
    src/libANGLE/renderer/DeviceImpl.cpp
    src/libANGLE/renderer/DisplayImpl.cpp
    src/libANGLE/renderer/driver_utils.cpp
    src/libANGLE/renderer/Format_table_autogen.cpp
    src/libANGLE/renderer/load_functions_table_autogen.cpp
    src/libANGLE/renderer/renderer_utils.cpp
    src/libANGLE/renderer/SurfaceImpl.cpp
    src/libANGLE/renderer/TextureImpl.cpp

    src/libANGLE/validationEGL.cpp
    src/libANGLE/validationES.cpp
    src/libANGLE/validationES1.cpp
    src/libANGLE/validationES2.cpp
    src/libANGLE/validationES3.cpp
    src/libANGLE/validationES31.cpp)

set(angle_libangle_d3d_common_srcs
    src/libANGLE/renderer/d3d/BufferD3D.cpp
    src/libANGLE/renderer/d3d/CompilerD3D.cpp
    src/libANGLE/renderer/d3d/DeviceD3D.cpp
    src/libANGLE/renderer/d3d/DisplayD3D.cpp
    src/libANGLE/renderer/d3d/DynamicHLSL.cpp
    src/libANGLE/renderer/d3d/EGLImageD3D.cpp
    src/libANGLE/renderer/d3d/FramebufferD3D.cpp
    src/libANGLE/renderer/d3d/HLSLCompiler.cpp
    src/libANGLE/renderer/d3d/ImageD3D.cpp
    src/libANGLE/renderer/d3d/IndexBuffer.cpp
    src/libANGLE/renderer/d3d/IndexDataManager.cpp
    src/libANGLE/renderer/d3d/NativeWindowD3D.cpp
    src/libANGLE/renderer/d3d/ProgramD3D.cpp
    src/libANGLE/renderer/d3d/RenderbufferD3D.cpp
    src/libANGLE/renderer/d3d/RendererD3D.cpp
    src/libANGLE/renderer/d3d/RenderTargetD3D.cpp
    src/libANGLE/renderer/d3d/ShaderD3D.cpp
    src/libANGLE/renderer/d3d/ShaderExecutableD3D.cpp
    src/libANGLE/renderer/d3d/SurfaceD3D.cpp
    src/libANGLE/renderer/d3d/SwapChainD3D.cpp
    src/libANGLE/renderer/d3d/TextureD3D.cpp
    src/libANGLE/renderer/d3d/VertexBuffer.cpp
    src/libANGLE/renderer/d3d/VertexDataManager.cpp)

set(angle_libangle_d3d_9_srcs
    src/libANGLE/renderer/d3d/d3d9/Blit9.cpp
    src/libANGLE/renderer/d3d/d3d9/Buffer9.cpp
    src/libANGLE/renderer/d3d/d3d9/Context9.cpp
    src/libANGLE/renderer/d3d/d3d9/DebugAnnotator9.cpp
    src/libANGLE/renderer/d3d/d3d9/Fence9.cpp
    src/libANGLE/renderer/d3d/d3d9/formatutils9.cpp
    src/libANGLE/renderer/d3d/d3d9/Framebuffer9.cpp
    src/libANGLE/renderer/d3d/d3d9/Image9.cpp
    src/libANGLE/renderer/d3d/d3d9/IndexBuffer9.cpp
    src/libANGLE/renderer/d3d/d3d9/NativeWindow9.cpp
    src/libANGLE/renderer/d3d/d3d9/Query9.cpp
    src/libANGLE/renderer/d3d/d3d9/Renderer9.cpp
    src/libANGLE/renderer/d3d/d3d9/renderer9_utils.cpp
    src/libANGLE/renderer/d3d/d3d9/RenderTarget9.cpp
    src/libANGLE/renderer/d3d/d3d9/ShaderExecutable9.cpp
    src/libANGLE/renderer/d3d/d3d9/StateManager9.cpp
    src/libANGLE/renderer/d3d/d3d9/SwapChain9.cpp
    src/libANGLE/renderer/d3d/d3d9/TextureStorage9.cpp
    src/libANGLE/renderer/d3d/d3d9/VertexBuffer9.cpp
    src/libANGLE/renderer/d3d/d3d9/VertexDeclarationCache.cpp)

set(angle_libangle_d3d_11_srcs
    src/libANGLE/renderer/d3d/d3d11/Blit11.cpp
    src/libANGLE/renderer/d3d/d3d11/Buffer11.cpp
    src/libANGLE/renderer/d3d/d3d11/Clear11.cpp
    src/libANGLE/renderer/d3d/d3d11/Context11.cpp
    src/libANGLE/renderer/d3d/d3d11/DebugAnnotator11.cpp
    src/libANGLE/renderer/d3d/d3d11/dxgi_format_map_autogen.cpp
    src/libANGLE/renderer/d3d/d3d11/dxgi_support_table.cpp
    src/libANGLE/renderer/d3d/d3d11/Fence11.cpp
    src/libANGLE/renderer/d3d/d3d11/formatutils11.cpp
    src/libANGLE/renderer/d3d/d3d11/Framebuffer11.cpp
    src/libANGLE/renderer/d3d/d3d11/Image11.cpp
    src/libANGLE/renderer/d3d/d3d11/IndexBuffer11.cpp
    src/libANGLE/renderer/d3d/d3d11/InputLayoutCache.cpp
    src/libANGLE/renderer/d3d/d3d11/PixelTransfer11.cpp
    src/libANGLE/renderer/d3d/d3d11/ProgramPipeline11.cpp
    src/libANGLE/renderer/d3d/d3d11/Query11.cpp
    src/libANGLE/renderer/d3d/d3d11/Renderer11.cpp
    src/libANGLE/renderer/d3d/d3d11/renderer11_utils.cpp
    src/libANGLE/renderer/d3d/d3d11/RenderStateCache.cpp
    src/libANGLE/renderer/d3d/d3d11/RenderTarget11.cpp
    src/libANGLE/renderer/d3d/d3d11/ResourceManager11.cpp
    src/libANGLE/renderer/d3d/d3d11/ShaderExecutable11.cpp
    src/libANGLE/renderer/d3d/d3d11/StateManager11.cpp
    src/libANGLE/renderer/d3d/d3d11/StreamProducerD3DTexture.cpp
    src/libANGLE/renderer/d3d/d3d11/SwapChain11.cpp
    src/libANGLE/renderer/d3d/d3d11/TextureStorage11.cpp
    src/libANGLE/renderer/d3d/d3d11/texture_format_table.cpp
    src/libANGLE/renderer/d3d/d3d11/texture_format_table_autogen.cpp
    src/libANGLE/renderer/d3d/d3d11/TransformFeedback11.cpp
    src/libANGLE/renderer/d3d/d3d11/Trim11.cpp
    src/libANGLE/renderer/d3d/d3d11/VertexArray11.cpp
    src/libANGLE/renderer/d3d/d3d11/VertexBuffer11.cpp)

set(angle_libangle_d3d_11_win32_srcs
    src/libANGLE/renderer/d3d/d3d11/win32/NativeWindow11Win32.cpp)

set(angle_libangle_d3d_11_winrt_srcs
    src/libANGLE/renderer/d3d/d3d11/winrt/CoreWindowNativeWindow.cpp
    src/libANGLE/renderer/d3d/d3d11/winrt/InspectableNativeWindow.cpp
    #src/libANGLE/renderer/d3d/d3d11/winrt/NativeWindow11WinRT.cpp
    src/libANGLE/renderer/d3d/d3d11/winrt/SwapChainPanelNativeWindow.cpp)

set(angle_libglesv2_srcs
    src/libGLESv2/entry_points_egl.cpp
    src/libGLESv2/entry_points_egl_ext.cpp
    src/libGLESv2/entry_points_gles_1_0_autogen.cpp
    src/libGLESv2/entry_points_gles_2_0_autogen.cpp
    src/libGLESv2/entry_points_gles_2_0_autogen.cpp
    src/libGLESv2/entry_points_gles_3_0_autogen.cpp
    src/libGLESv2/entry_points_gles_3_1_autogen.cpp
    src/libGLESv2/entry_points_gles_ext_autogen.cpp
    src/libGLESv2/global_state.cpp
    src/libGLESv2/proc_table_autogen.cpp
    src/libGLESv2/libGLESv2.cpp)

set(angle_egl_srcs
    src/libEGL/libEGL.cpp)

set(angle_image_util_srcs # FIXME: Only for Win32??
    src/image_util/copyimage.cpp
    src/image_util/imageformats.cpp
    src/image_util/loadimage.cpp
    src/image_util/loadimage_etc.cpp)

set(angle_systeminfo_srcs # FIXME: Only for D3d9??
    src/third_party/systeminfo/SystemInfo.cpp)

