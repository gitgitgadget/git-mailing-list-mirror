From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Tags
Date: Sat, 02 Jul 2005 21:55:16 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.02.19.55.13.345854@smurf.noris.de>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sat Jul 02 21:56:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Doo63-0004Fa-Sm
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 21:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVGBT4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 15:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVGBT4G
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 15:56:06 -0400
Received: from main.gmane.org ([80.91.229.2]:37566 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261268AbVGBT4C (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 15:56:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Doo5d-0004DM-6H
	for git@vger.kernel.org; Sat, 02 Jul 2005 21:55:49 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 21:55:49 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Jul 2005 21:55:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Eric W. Biederman wrote:

> So
> is there anything wrong with adding .git/refs/tags/tag-name.sign
> that is a traditional signature file?

The signature is already appended to the tag file itself (or can be).
See "git-tag-script".

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Democracy is that form of government where everybody gets what the majority
deserves.
					-- James Dale Davidson
