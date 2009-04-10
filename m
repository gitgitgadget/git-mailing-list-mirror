From: Aaron Digulla <digulla@hepe.com>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 13:11:10 +0200
Message-ID: <49DF294E.7010407@hepe.com>
References: <loom.20090410T084314-918@post.gmane.org> <fabb9a1e0904100330u61a7e252he546f0edc4e016a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 13:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsFFf-0000PU-6c
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 13:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935931AbZDJLst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 07:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935908AbZDJLss
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 07:48:48 -0400
Received: from sebigbos.hepe.com ([78.47.144.89]:43591 "EHLO www.hepe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935684AbZDJLsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 07:48:45 -0400
Received: from [194.230.154.168] (helo=[192.168.66.2])
	by www.hepe.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <digulla@hepe.com>)
	id 1LsEdk-0003Hr-Cf; Fri, 10 Apr 2009 13:11:21 +0200
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fabb9a1e0904100330u61a7e252he546f0edc4e016a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116254>

Sverre Rabbelier wrote:

>> I need a way to safely synchronize data between several places using an unsafe
>> storage (USB stick, Internet drive). So my question is: How much work would it
>> be to patch GIT to encrypt all files in the repository using AES-256?
> 
> Encrypt the entire drive flash drive [0], and then use git like
> normal, 0 changes required ;). You can also create an encrypted file,
> and then use git like normal, also 0 changes required!

How do I encrypt an Internet drive (like Dropbox)? Also, if possible, 
I'd like not to have to install any software on the local computer 
(well, besides git, obviously).

Regards,

-- 
Aaron "Optimizer" Digulla a.k.a. Philmann Dark
"It's not the universe that's limited, it's our imagination.
Follow me and I'll show you something beyond the limits."
http://www.pdark.de/                 http://blog.pdark.de/
