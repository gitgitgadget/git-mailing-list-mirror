From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 3/6] t9001: shorten send-email's output
Date: Wed, 8 Jun 2016 08:36:07 +0000
Message-ID: <20160608083607.GA9107@dcvr.yhbt.net>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-4-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, gitster@pobox.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:36:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYyF-0002lT-Ij
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbcFHIgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:36:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51164 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161337AbcFHIgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:36:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F325E1FF40;
	Wed,  8 Jun 2016 08:36:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160607140148.23242-4-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296772>

Tom Russello <tom.russello@grenoble-inp.org> wrote:
> Messages displayed by `send-email` should be shortened to avoid displaying
> unnecesseray informations.

unnecessary information.

In some of your other patches, the 'grep' can probably
be better replaced by 'fgrep' for fixed strings.
Otherwise, the '.' in the 'example.com' would match any
character instead of the intended dot.

Thanks.
