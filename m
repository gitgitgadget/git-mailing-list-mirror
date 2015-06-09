From: Jeff King <peff@peff.net>
Subject: Re: gitscm vs. git-scm
Date: Tue, 9 Jun 2015 10:21:28 -0400
Message-ID: <20150609142127.GA7894@peff.net>
References: <5576E2FE.4090105@drmicha.warpmail.net>
 <vpq382181wh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 16:22:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2KPc-0000UF-15
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 16:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919AbbFIOVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 10:21:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:43356 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932792AbbFIOVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 10:21:33 -0400
Received: (qmail 8952 invoked by uid 102); 9 Jun 2015 14:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 09:21:32 -0500
Received: (qmail 15232 invoked by uid 107); 9 Jun 2015 14:21:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 10:21:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jun 2015 10:21:28 -0400
Content-Disposition: inline
In-Reply-To: <vpq382181wh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271182>

On Tue, Jun 09, 2015 at 03:08:46PM +0200, Matthieu Moy wrote:

> I guess gitscm.com should just redirect to git-scm.com (sending the
> Location: field, and/or with stg like
> <meta http-equiv="Refresh" content="0; URL=http://git-scm.com" />

We (the git project) don't own gitscm.com. I don't recognize the name on
the whois:

  $ whois gitscm.com | grep ^Registrant
  Registrant Name: Jimmy Ho
  Registrant Organization: Jimhoyd LLC
  Registrant Street: PO Box 182
  Registrant City: Walnut Creek
  Registrant State/Province: California
  Registrant Postal Code: 94597
  Registrant Country: United States
  Registrant Phone: +1.4158468899
  Registrant Phone Ext: 
  Registrant Fax: 
  Registrant Fax Ext: 
  Registrant Email: support@jimhoyd.com

Doesn't seem like a domain squatter, as it redirects to git-scm.com
(albeit weirdly) and does not seem to inject ads or other crap.

-Peff
