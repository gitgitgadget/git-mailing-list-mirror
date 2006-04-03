From: Sam Vilain <sam@vilain.net>
Subject: Re: n-heads and patch dependency chains
Date: Tue, 04 Apr 2006 03:38:40 +1200
Message-ID: <1144078720.15809.49.camel@localhost.localdomain>
References: <4430D352.4010707@vilain.net>
	 <Pine.LNX.4.64.0604030727250.3781@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 03 17:39:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQR91-0004tl-8a
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 17:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWDCPjE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 11:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWDCPjE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 11:39:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:59793 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751730AbWDCPjC
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 11:39:02 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 7A2BA60D4; Tue,  4 Apr 2006 03:38:59 +1200 (NZST)
Received: from localhost.localdomain (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 581DB60B5;
	Tue,  4 Apr 2006 03:38:53 +1200 (NZST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604030727250.3781@g5.osdl.org>
X-Mailer: Evolution 2.4.1 
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18339>

On Mon, 2006-04-03 at 07:29 -0700, Linus Torvalds wrote:
> I really think that darcs is just "nice theory", and has nothing to do 
> with real life.
> 
> Terms like "patch calculus" may sound cool and useful, but let's face it, 
> the proof is in the pudding, and quite frankly, I would bet that trying to 
> do something like that on a real project would just be a total disaster.
>
> I want my merges simple. I want them to take a couple of seconds. I 
> don't want to see strange patch dependencies that nobody cares about.

Dave really was right with his keynote comment about nomenclature in
Dunedin.  I shouldn't even have put the term "patch calculus" in the
e-mail body at all :-P

Seriously, though, the rest of the report basically agrees with your
position.  Sorry if it was rambling and that key message wasn't clear.

We did kind of work out along the way that the best bits of patch
calculus were probably obtained with good use of topic branches.  Likely
if there are any key advances to be made, they will be found in the form
of clever ways to manage topic branches.

>  And I very much don't want to see theory over practice.

Theory?  Do I *look* like a theorist?

(looks around sheepishly)

This was valuable cross-culture field research!

(looks around at rather non-plussed eyes)

Hey, I found it quite enlightening, and at least a few other people were
amused by the ordeal.  And I learned a little bit more about git along
the way.

(waits for a 'hear', 'hear'!  silence.)

I'll get me coat.

Sam.
