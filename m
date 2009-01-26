From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Translations in Git release?
Date: Mon, 26 Jan 2009 09:54:56 +0000 (UTC)
Message-ID: <glk19g$2f5$1@ger.gmane.org>
References: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 10:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LROCt-0002c9-Ad
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 10:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZAZJzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbZAZJzK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 04:55:10 -0500
Received: from main.gmane.org ([80.91.229.2]:51631 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbZAZJzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 04:55:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LROBN-0003iF-Oe
	for git@vger.kernel.org; Mon, 26 Jan 2009 09:55:05 +0000
Received: from u-6-187.vpn.rwth-aachen.de ([137.226.102.187])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 09:55:05 +0000
Received: from heipei by u-6-187.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 09:55:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-6-187.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107181>

On 2009-01-25, Dill <sarpulhu@gmail.com> wrote:
> Is there a plan to include translations of the Documentation within
> Git or should they exist outside of the project?

My oppinion on localization of software (and its documentation) is 
generally a negative one. 

- People who use software like git are (in my experience) people who 
have a solid foundation of english, especially  when it comes to 
computer-topics.
- The effort that goes into translating the vast git documentation and 
keeping it up-to-date isn't small, energy better spent in other areas.
- Translating a lot of technical terms into a language like german is 
really ugly and not fun to read. I always prefer reading english 
documentation and using non-localized versions of programs as it enables 
me to easier partake in discussions about it and also enables me to 
google for error messages without trying every different language the 
message could be in ;)

But thats just me, if you want to start a translation effort knock 
yourself out

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
