From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How do gmail users try out patches from this list?
Date: Wed, 12 Aug 2009 10:23:15 +0200
Message-ID: <4A827BF3.8080208@drmicha.warpmail.net>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com> <20090811221408.GC12956@vidovic> <200908111917.19267.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, skillzero@gmail.com,
	git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 10:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb97Z-0003tE-Eq
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 10:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZHLIXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 04:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbZHLIXc
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 04:23:32 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33113 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684AbZHLIXb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 04:23:31 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0519F15B63;
	Wed, 12 Aug 2009 04:23:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 12 Aug 2009 04:23:31 -0400
X-Sasl-enc: J/JdyRaP7g2hcNfvk2O2Cv/VlT1uLH5t5+7OB3ABiwB7 1250065410
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 182086445;
	Wed, 12 Aug 2009 04:23:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <200908111917.19267.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125681>

Wesley J. Landaker venit, vidit, dixit 12.08.2009 03:17:
> On Tuesday 11 August 2009 16:14:08 Nicolas Sebrecht wrote:
>> The 11/08/09, skillzero@gmail.com wrote:
>>> Sorry if this is dumb question, but I didn't see any good info in my
>>> searches.
>>>
>>> How do gmail users normally apply patches that come through the list?
>>
>> It doesn't rely on your address mail provider but on your local email
>> workflow/MUA.
> 
> I'm not in this situation, but my guess is that a lot of people use gmail 
> primarily through the web interface (e.g. because of corporate firewalls or 
> some other reason). Maybe someone in that situation should make an new "git 
> imap-am" command? Kind of the reverse to imap-send. Just a thought. =)

Well, if they can't do imap (because of a firewall) git can't do imap...

I guess for them (webmail users) it would be better if we attached
patches, but we don't do that here. In any case, our list is mirrored on
gmane, and you can use the interface there. For example, you get the
first message in this thread using the gmane id or the message id like this:

http://article.gmane.org/gmane.comp.version-control.git/125591
http://mid.gmane.org/2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com

If you add /raw to those URLs you get the original message so that you
can happily wget/curl/browse and save away.

Michael
