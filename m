From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-submodule: wrap branch option with "<>" in usage
 strings.
Date: Wed, 24 Oct 2012 03:34:10 -0400
Message-ID: <20121024073410.GA25774@sigill.intra.peff.net>
References: <6332cbbfccd24f9d1ed37de424372ca354e9a4da.1351026021.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Oct 24 09:34:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQvTu-0004Ap-41
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 09:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799Ab2JXHeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 03:34:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53759 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934450Ab2JXHeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 03:34:13 -0400
Received: (qmail 27446 invoked by uid 107); 24 Oct 2012 07:34:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 03:34:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 03:34:10 -0400
Content-Disposition: inline
In-Reply-To: <6332cbbfccd24f9d1ed37de424372ca354e9a4da.1351026021.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208295>

On Tue, Oct 23, 2012 at 05:00:21PM -0400, W. Trevor King wrote:

> From: "W. Trevor King" <wking@tremily.us>
> 
> Use "-b <branch>" instead of "-b branch".  This brings the usage
> strings in line with other options, e.g. "--reference <repository>".
> 
> Signed-off-by: W. Trevor King <wking@tremily.us>

Thanks. Looks obviously correct to me.

-Peff
