From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 08:51:35 +0100
Message-ID: <85abmy47so.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	<alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
	<C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	<20080121195703.GE29792@mit.edu>
	<998717B0-0165-4383-AAB8-33BD2A49954E@sb.org>
	<20080121201530.GF29792@mit.edu>
	<8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
	<20080121204614.GG29792@mit.edu>
	<6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
	<20080121211802.GH29792@mit.edu>
	<45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
	<85zluy4xf0.fsf@lola.goethe.zz>
	<31F9ADDC-008D-4F06-97E6-CF1D16238DF9@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHDvg-0006uO-32
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 08:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbYAVHvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 02:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYAVHvl
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 02:51:41 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:50446 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203AbYAVHvk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 02:51:40 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 292D41F5040;
	Tue, 22 Jan 2008 08:51:39 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 11F2B2BEC16;
	Tue, 22 Jan 2008 08:51:39 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-008-019.pools.arcor-ip.net [84.61.8.19])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id E062B1BF3D2;
	Tue, 22 Jan 2008 08:51:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 996581C3D4E5; Tue, 22 Jan 2008 08:51:35 +0100 (CET)
In-Reply-To: <31F9ADDC-008D-4F06-97E6-CF1D16238DF9@sb.org> (Kevin Ballard's
	message of "Mon, 21 Jan 2008 21:34:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5519/Tue Jan 22 05:46:17 2008 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71426>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 21, 2008, at 5:38 PM, David Kastrup wrote:
>
>>> How many times must I say I never suggested actually changing git's
>>> hashing algorithm? And if you want me to suggest a fix to git that
>>> works, first you have to wait for me to learn how git's internals
>>> work, and frankly, I have too much work on my plate right now to
>>> devote the time necessary to learning git's internals well enough to
>>> fix this problem.
>>
>> Then please understand that you have too much work on your plate right
>> now to devote the time necessary to provide any constructive
>> criticism.
>> A smart person in this situation would shut up until he has the time.
>
> A smart person would not join the conversation late and respond to
> points that have already been exhausted ages ago.

Find somebody willing to explain to you the difference between Email and
IRC, and how to read "Date:" headers.  I have no doubt you'll be able to
grasp the basic involved principles in less than a week.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
