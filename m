From: Kyle Moffett <mrlinuxman@mac.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 14:29:49 -0500
Message-ID: <0D595B77-FAD6-4899-B475-8C1190C28E0F@mac.com>
References: <478E1FED.5010801@web.de> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <4C21C1AF-40B0-48C7-8F0E-2DAF3C5FAB29@sb.org> <46a038f90801162051s5ce40abcm623599269943a24@mail.gmail.com> <ACDB98F4-178C-43C3-99C4-A1D03DD6A8F5@sb.org> <A915BECA-A486-477B-A07D-D1033E44DCBD@adacore.com> <85zlv435z4.fsf@stiegl.mj.niksun.com> <3D987338-EC1E-422F-850D-D8C52345A6A7@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Andrew Heybey <ath@niksun.com>, Geert Bosch <bosch@adacore.com>,
	"Kevin Ballard <kevin@sb.org>Martin Langhoff" 
	<martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 20:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGJWg-0002bf-CD
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 20:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbYASTiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 14:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYASTiR
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 14:38:17 -0500
Received: from smtpoutm.mac.com ([17.148.16.70]:59513 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbYASTiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 14:38:16 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jan 2008 14:38:16 EST
Received: from mac.com (asmtp002-s [10.150.69.65])
	by smtpoutm.mac.com (Xserve/smtpout007/MantshX 4.0) with ESMTP id m0JJTrIw025587;
	Sat, 19 Jan 2008 11:29:53 -0800 (PST)
Received: from [10.0.3.253] (ip70-187-212-71.dc.dc.cox.net [70.187.212.71])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp002/MantshX 4.0) with ESMTP id m0JJTnAG016729
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 19 Jan 2008 11:29:50 -0800 (PST)
In-Reply-To: <3D987338-EC1E-422F-850D-D8C52345A6A7@sb.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71126>

On Jan 17, 2008, at 10:04, Kevin Ballard wrote:
> The main problem with this approach is you know for certain that  
> using HFSX as the boot partition is barely tested by Apple, and  
> certainly untested by third-party apps. This means the potential for  
> breakage is extremely high.

No, actually, HFSX boot partitions are fairly well tested by Apple and  
most 3rd-party programs.  I had one for a while and the only problems  
I encountered were with programs ported from Windows without Mac  
versions, such as "Microsoft Office for Mac" and "World of Warcraft".   
"Quake 4" has a few quirks which are easily worked around.

Cheers,
Kyle Moffett
