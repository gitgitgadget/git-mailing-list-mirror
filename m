From: Andreas Ericsson <ae@op5.se>
Subject: Re: [SCuMD]
Date: Thu, 27 Aug 2009 12:04:13 +0200
Message-ID: <4A965A1D.3060104@op5.se>
References: <4A965799.6050204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Senkowski <csenkowski@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 12:04:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgbqM-0006TX-3P
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 12:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbZH0KEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 06:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbZH0KEZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 06:04:25 -0400
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47408 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751952AbZH0KEY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 06:04:24 -0400
Received: from source ([74.125.78.24]) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSpZaKGCpSBgQhCrKd2ctx1gAotvQlYnB@postini.com; Thu, 27 Aug 2009 03:04:26 PDT
Received: by ey-out-2122.google.com with SMTP id 22so213096eye.11
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 03:04:24 -0700 (PDT)
Received: by 10.210.136.17 with SMTP id j17mr9098422ebd.61.1251367463878;
        Thu, 27 Aug 2009 03:04:23 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm99981eyz.25.2009.08.27.03.04.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 03:04:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A965799.6050204@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127152>

Christian Senkowski wrote:
> Hi,
> 
> I cloned SCuMD directly via git and started it but got following error:
> 
> ~/scumd$ ./run.sh
> Exception in thread "main" java.lang.NoClassDefFoundError:
> com.asolutions.scmsshd.SCuMD
>    at gnu.java.lang.MainThread.run(libgcj.so.90)
> Caused by: java.lang.ClassNotFoundException:
> com.asolutions.scmsshd.SCuMD not found in
> gnu.gcj.runtime.SystemClassLoader{urls=[file:depend/lib/jgit.jar,file:depend/lib/minasshd.jar,file:lib/aopalliance-1.0.jar,file:lib/bcprov-jdk15-140.jar,file:lib/commons-io-1.4.jar,file:lib/commons-logging-1.0.4.jar,file:./,file:lib/jline-0.9.1.jar,file:lib/jline-0.9.94.jar,file:lib/jpam-1.1.jar,file:lib/jsch-0.1.40.jar,file:lib/jzlib-1.0.7.jar,file:lib/log4j-1.2.13.jar,file:lib/slf4j-api-1.5.2.jar,file:lib/slf4j-log4j12-1.4.3.jar,file:lib/spring-beans-2.5.5.jar,file:lib/spring-context-2.5.5.jar,file:lib/spring-core-2.5.5.jar],
> parent=gnu.gcj.runtime.ExtensionClassLoader{urls=[], parent=null}}
>    at java.net.URLClassLoader.findClass(libgcj.so.90)
>    at gnu.gcj.runtime.SystemClassLoader.findClass(libgcj.so.90)
>    at java.lang.ClassLoader.loadClass(libgcj.so.90)
>    at java.lang.ClassLoader.loadClass(libgcj.so.90)
>    at gnu.java.lang.MainThread.run(libgcj.so.90)
> 
> 
> Please help me out :)
> 

Please refer to the SCuMD mailing list for this SCuMD related question.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
