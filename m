From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sun, 29 Mar 2009 08:07:10 -0700 (PDT)
Message-ID: <1238339230806-2552797.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> <1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> <1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> <1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> <1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> <1238327564546-2552334.post@n2.nabble.com> <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com> <1238328537685-2552369.post@n2.nabble.com> <fabb9a1e0903290535y59cd3a1fvd5a
 7d3476dff45bc@mail.gmail.com> <1238331203288-2552470.post@n2.nabble.com> <fabb9a1e0903290555o3503b58ie097f8f8336c4401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 17:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnwcy-0006JZ-Ic
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 17:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525AbZC2PHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757515AbZC2PHQ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 11:07:16 -0400
Received: from kuber.nabble.com ([216.139.236.158]:37768 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757016AbZC2PHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 11:07:15 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LnwbO-0003pz-QO
	for git@vger.kernel.org; Sun, 29 Mar 2009 08:07:10 -0700
In-Reply-To: <fabb9a1e0903290555o3503b58ie097f8f8336c4401@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115028>




Heya,

On Sun, Mar 29, 2009 at 14:53, jamespetts <jamespetts@yahoo.com> wrote:
>
> "Unable to determine upstream SVN infromation from working tree history".
>
> Have I done something wrong...?

I'm afraid this is where my git-svn knowledge is no longer sufficient
:(. I have had the same problem myself, and I don't know how to fix
it, perhaps Eric has a moment to enlighten?

Supposing that Eric is unable to find a solution - would there be any mileage in doing it manually? That is, checking out the SVN repository into a local directory, initialising that as a Git repository, and then pushing it to Github? If so, would that make it any harder to re-synchronise with my branch than the git-svn method?
-- 
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2552797.html
Sent from the git mailing list archive at Nabble.com.
