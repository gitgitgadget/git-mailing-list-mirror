From: Kirk Fraser <overcomer.man@gmail.com>
Subject: Bug Report
Date: Sun, 7 Apr 2013 22:20:06 -0700
Message-ID: <CAC34_pSe8jH+mi1Ys5uqHbgJY+06pE9-sDHeqU6gZTrTQ4UQVA@mail.gmail.com>
References: <CAC34_pT9zwZDnUjo1bTUZabD02M48=_+77-mNCA5adWTgxuYgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:51:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5sz-0000sy-7O
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab3DHFUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 01:20:09 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:43778 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab3DHFUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 01:20:08 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so5363082lbh.32
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=9ANEjGgUlxV4c3AvgGHxiMce0h78LXwgej6AqefZXh4=;
        b=yLLoz79qR4j2zx3m7sbWUheAtrp2WM+kAJ6p4fkeSChZI+LKK8wNLs2It9cKplK4ti
         jrxPu/MbPRnyJ7LaIK8DhMQe7pGb039XoiZ8dfA/R0a+UrhssPw6Xlyfns0biVhykit2
         v2HxhIiB2VB+hnfq/e8obpqfEVvNthmqlNQXB2ypt+Xf6fcxJ14uZBkflyj6d2Fy6nWt
         Nmj7cnJnXdCwG1vCt0f5zZULHwqjnvp/1ObesXXzFsLAuH9sdHlFCzXj4NT0YL346tvR
         lqpF0ME0oknYz2/laDYgyOVoAkalAG4PNQw76vpt9UUFVd0kuELlVh7OMzRtPD4BZyrx
         t6rw==
X-Received: by 10.112.173.70 with SMTP id bi6mr2355195lbc.116.1365398406773;
 Sun, 07 Apr 2013 22:20:06 -0700 (PDT)
Received: by 10.114.177.244 with HTTP; Sun, 7 Apr 2013 22:20:06 -0700 (PDT)
In-Reply-To: <CAC34_pT9zwZDnUjo1bTUZabD02M48=_+77-mNCA5adWTgxuYgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220400>

It appears your Amazon download server is too slow.  Perhaps getting
an old used XP system and setting it up as a server will solve this
problem.

Here's the details:


PLATFORM VERSION INFO
	Windows 			: 6.1.7601.65536 (Win32NT)
	Common Language Runtime 	: 4.0.30319.296
	System.Deployment.dll 		: 4.0.30319.1 (RTMRel.030319-0100)
	clr.dll 			: 4.0.30319.296 (RTMGDR.030319-2900)
	dfdll.dll 			: 4.0.30319.1 (RTMRel.030319-0100)

SOURCES
	Deployment url			: http://github-windows.s3.amazonaws.com/GitHub.application
						Server		: AmazonS3
	Application url			:
http://github-windows.s3.amazonaws.com/Application%20Files/GitHub_1_0_41_2/GitHub.exe.manifest
						Server		: AmazonS3

IDENTITIES
	Deployment Identity		: GitHub.application, Version=1.0.41.2,
Culture=neutral, PublicKeyToken=317444273a93ac29,
processorArchitecture=x86
	Application Identity		: GitHub.exe, Version=1.0.41.2,
Culture=neutral, PublicKeyToken=317444273a93ac29,
processorArchitecture=x86, type=win32

APPLICATION SUMMARY
	* Installable application.
	* Trust url parameter is set.
ERROR SUMMARY
	Below is a summary of the errors, details of these errors are listed
later in the log.
	* Activation of
http://github-windows.s3.amazonaws.com/GitHub.application resulted in
exception. Following failure messages were detected:
		+ Downloading http://github-windows.s3.amazonaws.com/Application
Files/GitHub_1_0_41_2/7za.exe.deploy did not succeed.
		+ Unable to read data from the transport connection: An existing
connection was forcibly closed by the remote host.
		+ An existing connection was forcibly closed by the remote host

COMPONENT STORE TRANSACTION FAILURE SUMMARY
	No transaction error was detected.

WARNINGS
	There were no warnings during this operation.

OPERATION PROGRESS STATUS
	* [4/7/2013 9:17:17 PM] : Activation of
http://github-windows.s3.amazonaws.com/GitHub.application has started.
	* [4/7/2013 9:17:30 PM] : Processing of deployment manifest has
successfully completed.
	* [4/7/2013 9:17:30 PM] : Installation of the application has started.
	* [4/7/2013 9:17:34 PM] : Processing of application manifest has
successfully completed.
	* [4/7/2013 9:23:57 PM] : Found compatible runtime version 4.0.30319.
	* [4/7/2013 9:23:57 PM] : Request of trust and detection of platform
is complete.

ERROR DETAILS
	Following errors were detected during this operation.
	* [4/7/2013 9:51:39 PM]
System.Deployment.Application.DeploymentDownloadException (Unknown
subtype)
		- Downloading http://github-windows.s3.amazonaws.com/Application
Files/GitHub_1_0_41_2/7za.exe.deploy did not succeed.
		- Source: System.Deployment
		- Stack trace:
			at System.Deployment.Application.SystemNetDownloader.DownloadSingleFile(DownloadQueueItem
next)
			at System.Deployment.Application.SystemNetDownloader.DownloadAllFiles()
			at System.Deployment.Application.FileDownloader.Download(SubscriptionState
subState)
			at System.Deployment.Application.DownloadManager.DownloadDependencies(SubscriptionState
subState, AssemblyManifest deployManifest, AssemblyManifest
appManifest, Uri sourceUriBase, String targetDirectory, String group,
IDownloadNotification notification, DownloadOptions options)
			at System.Deployment.Application.ApplicationActivator.DownloadApplication(SubscriptionState
subState, ActivationDescription actDesc, Int64 transactionId,
TempDirectory& downloadTemp)
			at System.Deployment.Application.ApplicationActivator.InstallApplication(SubscriptionState&
subState, ActivationDescription actDesc)
			at System.Deployment.Application.ApplicationActivator.PerformDeploymentActivation(Uri
activationUri, Boolean isShortcut, String textualSubId, String
deploymentProviderUrlFromExtension, BrowserSettings browserSettings,
String& errorPageUrl)
			at System.Deployment.Application.ApplicationActivator.ActivateDeploymentWorker(Object
state)
		--- Inner Exception ---
		System.IO.IOException
		- Unable to read data from the transport connection: An existing
connection was forcibly closed by the remote host.
		- Source: System
		- Stack trace:
			at System.Net.ConnectStream.Read(Byte[] buffer, Int32 offset, Int32 size)
			at System.Deployment.Application.SystemNetDownloader.DownloadSingleFile(DownloadQueueItem
next)
		--- Inner Exception ---
		System.Net.Sockets.SocketException
		- An existing connection was forcibly closed by the remote host
		- Source: System
		- Stack trace:
			at System.Net.Sockets.Socket.Receive(Byte[] buffer, Int32 offset,
Int32 size, SocketFlags socketFlags)
			at System.Net.Sockets.NetworkStream.Read(Byte[] buffer, Int32
offset, Int32 size)

COMPONENT STORE TRANSACTION DETAILS
	No transaction information is available.



-- 
Kirk W. Fraser
http://freetom.info/TrueChurch - Replace the fraud churches with the
true church.
http://congressionalbiblestudy.org - Fix America by first fixing its
Christian foundation.
http://freetom.info - Example of False Justice common in America
