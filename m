From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: [ANNOUNCE] ugit: the pythonic git gui
Date: Fri, 04 Jan 2008 10:05:35 +0100
Message-ID: <flkstb$mts$1@ger.gmane.org>
References: <402731c90712281449g3d0c4f53w48c65dc8883bbbb3@mail.gmail.com>	 <8b65902a0801020242x425b792xbfa5ee69a13c2573@mail.gmail.com>	 <402731c90801021920h284bb84dn29151dccd90eed2a@mail.gmail.com> <e5bfff550801032315v1d2b98f7s4c22cd466e16f524@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 10:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAiVb-00078y-Pf
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbYADJGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYADJGE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:06:04 -0500
Received: from main.gmane.org ([80.91.229.2]:41993 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793AbYADJGD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:06:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JAiV2-0004Cf-Dh
	for git@vger.kernel.org; Fri, 04 Jan 2008 09:05:57 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 09:05:56 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 09:05:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550801032315v1d2b98f7s4c22cd466e16f524@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69569>

Marco Costalba wrote:
> On Jan 3, 2008 4:20 AM, David <davvid@gmail.com> wrote:
>> I don't have any fancy mac or windows installers at the moment (Linux
>> is my primary platform) though I am working on packaging soon.
>>
> 
> Regarding windows installer I was very happy with Inno Setuo that I
> didn't know but I found out be very simple to learn and powerful.

Just a question: why don't you package the two programs together? From a 
packager POV it would makes sense because the Qt libs will be shared. 
And from a user POV you definitely don't want to intall two very related 
  packages that ask the same question: where is git? :-)

Abdel.
