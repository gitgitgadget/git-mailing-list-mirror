From: Jeff King <peff@peff.net>
Subject: Re: Project idea: github-like diff view
Date: Sun, 20 Apr 2014 10:46:20 -0400
Message-ID: <20140420144620.GA16596@sigill.intra.peff.net>
References: <CACsJy8CQxPrqs31nBvr_oPRD3EJ6Hu-Lq=++7nWpxx5BQZYi8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 16:46:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbt12-0005SI-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 16:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372AbaDTOqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 10:46:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:34848 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755452AbaDTOqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 10:46:23 -0400
Received: (qmail 15746 invoked by uid 102); 20 Apr 2014 14:46:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Apr 2014 09:46:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Apr 2014 10:46:20 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CQxPrqs31nBvr_oPRD3EJ6Hu-Lq=++7nWpxx5BQZYi8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246550>

On Sun, Apr 20, 2014 at 04:58:28PM +0700, Duy Nguyen wrote:

> - --color-words within unified diff format, using background color to
> show what part of the line has changed. This is only enabled for
> 1-line changes.

See contrib/diff-highlight.

-Peff
