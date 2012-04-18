From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Wed, 18 Apr 2012 20:34:18 +0200
Message-ID: <20120418183418.GA23447@ecki>
References: <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
 <7vvckzws73.fsf@alter.siamese.dyndns.org>
 <20120416165024.GF13366@hmsreliant.think-freely.org>
 <20120416214247.GA5606@ecki>
 <20120417105604.GB11462@hmsreliant.think-freely.org>
 <20120417213851.GA20082@ecki>
 <20120418104859.GB22172@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:54:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKa1B-00039m-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 20:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab2DRSyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 14:54:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:12223 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab2DRSyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 14:54:12 -0400
Received: from [127.0.0.1] (p5B22CC82.dip.t-dialin.net [91.34.204.130])
	by bsmtp.bon.at (Postfix) with ESMTP id 1247210028;
	Wed, 18 Apr 2012 20:50:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120418104859.GB22172@hmsreliant.think-freely.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195880>

On Wed, Apr 18, 2012 at 06:48:59AM -0400, Neil Horman wrote:
>
> Given that we agree on our ability to consistently not use master
> above, what if we table this discussion for now, leave the tests as
> they are, and fix them all up in a separate patch set? Does that sound
> reasonable?

Absolutely.
