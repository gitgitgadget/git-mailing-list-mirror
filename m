From: Adam Megacz <adam@megacz.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in summary
Date: Sat, 16 Jan 2010 02:56:21 +0000
Organization: Myself
Message-ID: <xuu2hbqm4v1m.fsf@nowhere.com>
References: <20100113173408.GA16652@coredump.intra.peff.net> <20100113173951.GC16786@coredump.intra.peff.net> <1DDB570B-350A-40A0-B6E4-ADBDF4BE6BD2@wincent.com> <20100113184510.GA22849@coredump.intra.peff.net> <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 03:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVyqK-0005K0-EX
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 03:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116Ab0APC4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 21:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758199Ab0APC4r
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 21:56:47 -0500
Received: from lo.gmane.org ([80.91.229.12]:59553 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596Ab0APC4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 21:56:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NVyqB-0005IE-Q0
	for git@vger.kernel.org; Sat, 16 Jan 2010 03:56:43 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 03:56:43 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 03:56:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:RhJ6/YXtQjiBfErwepEvb5T45w0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137193>


Wincent Colaiuta <win@wincent.com> writes:
> Fair enough, but I'm sighing here at the thought of people jumping in  
> and using git commands without even having looked at _any_ of the  
> zillions of "your first 10 minutes with Git" tutorials out there,  

I don't think that's what this thread is really about, although helping
those people might be a harmless side-effect.

>> and people who have git configured on another machine but are using
>> _this_ machine for the first time).

For the record, this is what I have been burned by several times now.

I'm now stuck with a bunch of repositories I can no longer fix because
data blindly yanked out of libnss and never shown to me was then SHA-1
signed for all eternity.  It's incredibly frustrating.

Thank you for taking steps to save others from this frustration in the
future.  I appreciate it.

  - a
