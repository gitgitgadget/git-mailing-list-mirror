From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary (long)
Date: Fri, 05 Oct 2007 09:57:30 +0200
Message-ID: <4705EE6A.6020006@op5.se>
References: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com> <CDD8E66B-44E0-4258-A3CC-4E48BC58FD2F@lrde.epita.fr> <8fe92b430710040759r5777264aj5ecb09e0252fef9a@mail.gmail.com> <20071005014229.GS2137@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 09:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idi4C-000839-6B
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 09:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbXJEH5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 03:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbXJEH5g
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 03:57:36 -0400
Received: from mail.op5.se ([193.201.96.20]:55688 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbXJEH5f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 03:57:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 07C92194466;
	Fri,  5 Oct 2007 09:57:34 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rxbzln6BGfr9; Fri,  5 Oct 2007 09:57:32 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 545CF194462;
	Fri,  5 Oct 2007 09:57:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071005014229.GS2137@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60043>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> On 10/4/07, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
>>> On Oct 4, 2007, at 11:12 AM, Jakub Narebski wrote:
>>>> Note that Git is GPLv2, and it will probably stay that forever, so you
>>>> are _free_ to start a commercial support scheme for Git, but others
>>>> are free not to choose it. This question is to get to know if there is
>>>> sufficient demand for commercial Git support for it to be viable.
>>> Once again (AFAIR this was already raised during one of the previous
>>> summary) what's the link between GPLv2 and commercial support?  You
>>> seem to imply that because Git won't move to GPLv3, it's a good thing
>>> for potential paid support, or something.  I don't quite see how
>>> GPLvX comes into play with commercial support.  I'm not a license
>>> expert though.
>> The only link between GPL and commercial support is that GPL does not
>> prohibit commercial support (like noncommercial-free licenses for example),
>> and that having commercial support doesn't mean that license would change
>> to proprietary (it cannot).
> 
> Right.  There has been some discussion in the past about forming
> "The Git Company".
> 
> When this survey question was first posed there was some concern that
> Git might move to a commerical license of some sort and perhaps not
> be GPLvX anymore.  That concern is a non-issue; the copyrights for
> Git are held by over 300 people, many of whom are kernel hackers and
> strong believers in the value of GPLv2.  I'm not a kernel hacker,
> but I also believe strongly in the value of the GPLv2 license.
> You won't see me agreeing to move code I wrote to a non-GPL license
> anytime soon.  Most (if not all!) of Git's authors feel the same way.
> 
> There's several reasons why forming "The Git Company" might help
> the overall Git cause, and this question was a feeler to see if
> the community was interested in acquiring support through it.  Many
> other open source projects seem to get some benefit from having a
> company loosely affiliated with them, not the least of which are
> things like:
> 
>   - some of the developers can focus more time on the project and
>     still keep food on the table;
> 
>   - there are people focused on advertising/marketing the project
>     and its benfits to potential end-users;
> 
>   - companies that feel warm-and-fuzzy by having a phone number they
>     can call for help are more likely to want to use the project
>     for critical services;
> 
>   - companies that want training or short-term consulting services
>     know who they can contact for expertise.
> 
> and the list goes on.  The problem with said company is it costs
> money to keep the lights on and employees fed; money which obviously
> cannot be extorted from users through arcane licensing agreements.

Actually it can. I work for precisely such a company (although using
Nagios, cacti and syslog-ng as the base of our products rather than
git). The GPL doesn't state how one is allowed to charge money for
the products, but since larger networks with more users generate more
support calls, we also use a license payment model, where larger
customers pay more and smaller pay less.

The difference between proprietary software is that we have to trust
ur customers to *want* to pay the licenses, as it would be ridiculously
easy for them to replace our versions of the programs with the pristine
oss kind, or even with our patches, as we aren't allowed to keep them
private. However, doing so voids the support-agreement, as we don't take
support for code we haven't audited and tested. In other words, we *must*
provide first-class support and coding aid to our customers, or they
won't want to pay anymore. In practice, it all works out rather well, and
everyone gets something they want.

* I get paid to work with something I like.
* Customers get support, well-tested upgrades and nifty extensions.
* Project maintainers get patches, money, hardware and appreciation.

That last bit is important though. It's not terribly expensive for us to
buy a couple of books or a laptop and send it as a christmas gift to some
project maintainer, but doing so shows appreciation and also buys us the
attention of the developers for when we want our feature-patches accepted ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
