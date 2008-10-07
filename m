From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit bug] git user settings not retrieved when launched for
 Windows explorer
Date: Tue, 07 Oct 2008 13:36:20 +0200
Message-ID: <48EB49B3.1090509@lyx.org>
References: <48EB10C8.4070009@lyx.org> <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnAsk-0002YQ-Ly
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYJGLg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbYJGLg2
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:36:28 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:56751 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbYJGLg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:36:28 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 12882B0135;
	Tue,  7 Oct 2008 13:36:27 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp7-g19.free.fr (Postfix) with ESMTP id DDE9BB012E;
	Tue,  7 Oct 2008 13:36:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97694>

On 07/10/2008 13:10, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 9:33 AM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>> Dear Marco,
>>
>> When I double click on qgit.exe, the user name and email are not shown in
>> the user settings (for any of the 3 combo values). But if I run qgit from
>> the commandline at the mysysgit bash prompt, the boxes are properly filled.
>> I would like to debug it but, as I reported last week, the MSVC project
>> doesn't work for me.
>>
>>      
>
> Sound like a problem of startup directory: on the command line you
> start from the right directory...when you double click on which repo
> qgit is open ?
>    

None of course. But when I open a repository manually I would expect 
that this is properly filled in.

And if I launch qgit with the context menu (right clicking a directory 
in the Explorer), qgit never managed to open the repository.

Abdel.
