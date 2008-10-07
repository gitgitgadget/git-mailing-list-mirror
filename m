From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGit bug] git user settings not retrieved when launched for
 Windows explorer
Date: Tue, 07 Oct 2008 13:42:46 +0200
Message-ID: <48EB4B36.2090301@lyx.org>
References: <48EB10C8.4070009@lyx.org> <e5bfff550810070416y4db5a37t7302c2a0562f1527@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 13:44:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnAz5-0004lO-7i
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 13:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbYJGLmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 07:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYJGLmz
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 07:42:55 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:46876 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753033AbYJGLmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 07:42:54 -0400
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 4CAC13EA12C;
	Tue,  7 Oct 2008 13:42:53 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp4-g19.free.fr (Postfix) with ESMTP id DF7D93EA142;
	Tue,  7 Oct 2008 13:42:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070416y4db5a37t7302c2a0562f1527@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97696>

On 07/10/2008 13:16, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 9:33 AM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>> Dear Marco,
>>
>>
>> By the way, these two edit boxes are not editable on Windows, is that on
>> purpose? If yes, maybe we could let the user change them is 'Local config'
>> is selected and call the appropriate git function?
>>
>>      
>
> I know this limitation. I was just too lazy to implement edit
> myself...it would be a nice patch to have tough ;-)
>    

I am not sure I'll find the time to learn enough about git internals to 
do that kind of stuff. Maybe later.

Abdel.
