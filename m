From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 12:53:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710171246500.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> 
 <471476B7.5050105@users.sourceforge.net>  <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
  <47148F72.1090602@users.sourceforge.net>  <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
  <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
  <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> 
 <1192565900.6430.16.camel@athena>  <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
  <20071017015109.303760cc@localhost.localdomain> 
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> 
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> 
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> 
 <1192645509.6640.21.camel@athena>  <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
 <1192649598.6640.44.camel@athena>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Tobin <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEz0-0002pB-Vk
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbXJQTyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760891AbXJQTyb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:54:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40869 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758850AbXJQTya (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 15:54:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HJrwTn020663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 12:53:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9HJrwYQ005433;
	Wed, 17 Oct 2007 12:53:58 -0700
In-Reply-To: <1192649598.6640.44.camel@athena>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61421>



On Wed, 17 Oct 2007, Tom Tobin wrote:
> 
> And, of course, this still comes up against the *benefits* of
> all-spaces.  Benefits which have been mentioned by several people;
> benefits which you refuse to *acknowledge*, even if they don't sway you.

I notice how you didn't even list them. Why? Because they don't exist? 

So here's the deal: I claim that "use hard-tabs, and accept that they are 
8 characters wide" is a provably working situation. For lots of *large* 
projects. I'm not some odd-ball person here, I bet that if you go and look 
at any sourceforge entry that is written in C (which is the language we're 
debating here), you'll find that the ones that use hard-tabs (even if they 
use spaces for smaller indents) are the vast majority.

So what's your point? You're pushing something that is provably odd-ball, 
since almost nobody uses it, and you cannot even state what the huge 
advantages are, and you claim that I'm the one that ignores them, when it 
is *you* who have refused to acknowledge that there are reasons to *not* 
do it (one big reason being that there are current existing and 
productive developers that definitely do *not* want to change - and no, 
it wasn't just me, either).

Your arguments make no sense. So *of*course* they don't sway me.

And you know what? I don't much care if you aren't swayed by mine. It's to 
some degree a matter of taste, and the fact is, if you don't like the 
current git model, you can go away and play with your own model. It *is* 
open source, after all. 

Put another way: if you cannot respect the wishes of the people who have 
done the work, then I damn well have no reason what-so-ever to respect 
*yours*. 

		Linus
