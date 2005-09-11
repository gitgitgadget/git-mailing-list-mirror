From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Sun, 11 Sep 2005 18:37:24 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.11.16.37.20.483911@smurf.noris.de>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com> <432060B8.6080408@gmail.com> <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net> <432089D5.7000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Sep 11 18:42:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEUsb-0005rn-R1
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 18:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVIKQkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVIKQkb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 12:40:31 -0400
Received: from main.gmane.org ([80.91.229.2]:16002 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964806AbVIKQka (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 12:40:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EEUrW-0005Iq-3z
	for git@vger.kernel.org; Sun, 11 Sep 2005 18:39:26 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 18:39:26 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 18:39:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8299>

Hi, A Large Angry SCM wrote:

> Think about a directory containing directories "foo" and "foo.txt":
> 
Can you tell us why you're using extensions in the first place?

I propose using no extensions whatsoever: simply mirror the refs/ tree.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The rich get rich, and the poor get poorer.
The haves get more, the have-nots die.
