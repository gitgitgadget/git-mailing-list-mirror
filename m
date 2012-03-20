From: Jeff King <peff@peff.net>
Subject: majordomo subscription woes
Date: Tue, 20 Mar 2012 14:32:46 -0400
Message-ID: <20120320183246.GA21429@sigill.intra.peff.net>
References: <001636c5c21b02c35904bba0ff9a@google.com>
 <201203201637.10417.jnareb@gmail.com>
 <7v62dz6v5c.fsf@alter.siamese.dyndns.org>
 <201203201844.55155.jnareb@gmail.com>
 <20120320175422.GA20669@sigill.intra.peff.net>
 <4F68C5E4.3050306@andrewalker.net>
 <20120320181857.GA20804@sigill.intra.peff.net>
 <4F68CBC4.1010507@andrewalker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?QW5kcsOp?= Walker <andre@andrewalker.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 19:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA3rd-0000Ll-LB
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 19:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab2CTSct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 14:32:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54619
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755405Ab2CTScs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 14:32:48 -0400
Received: (qmail 12735 invoked by uid 107); 20 Mar 2012 18:33:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Mar 2012 14:33:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2012 14:32:46 -0400
Content-Disposition: inline
In-Reply-To: <4F68CBC4.1010507@andrewalker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193532>

On Tue, Mar 20, 2012 at 03:26:12PM -0300, Andr=C3=A9 Walker wrote:

> On 03/20/2012 03:18 PM, Jeff King wrote:
> >It sounds like you are doing it right. And your emails look OK to me
> >(and the list is accepting them when cc'd). Your original mails may =
have
> >been greylisted, and waiting on your mail server to re-send them.
> >Depending on how your mail server is configured, that might be a few
> >minutes or a few hours. How long ago did you try?
>
> Right. The first time was more than 11 hours ago, and the second 1
> hour ago. Is there a list administrator who can whitelist my address?

We can ask postmaster@vger, but before we do that, there's one more
thing to check.  Majordomo will send a confirmation email with a code i=
n
it. Can you check on your end that majordomo's response email wasn't
blocked as spam?

-Peff
