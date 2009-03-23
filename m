From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Mon, 23 Mar 2009 02:42:42 -0400
Message-ID: <20090323064242.GB1119@coredump.intra.peff.net>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com> <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 07:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LldtS-0005jl-Mn
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 07:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZCWGms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 02:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbZCWGms
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 02:42:48 -0400
Received: from peff.net ([208.65.91.99]:33431 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbZCWGms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 02:42:48 -0400
Received: (qmail 19071 invoked by uid 107); 23 Mar 2009 06:42:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 02:42:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 02:42:42 -0400
Content-Disposition: inline
In-Reply-To: <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114246>

On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:

>  tt.literal, code.literal {
>    color: navy;
> +  font-size: 1em;
> +}

Isn't 1em already the default size? Or are you trying to override some
other size specification elsewhere? It's hard to tell what the goal is
because your commit message merely says "improve".

-Peff
