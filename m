From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Missing capabilities in
 Documentation/technical/protocol-capbilities.txt
Date: Wed, 17 Jul 2013 13:31:40 +0200
Message-ID: <20130717113140.GA22252@ecki.lan>
References: <CACsJy8BcEfc33HNxQB+_msbkbcxFfqg1xOpeRxNGL_cUqruE0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 14:03:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzQRm-0002Z1-2n
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab3GQMDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 08:03:00 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:65365 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754039Ab3GQMC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:02:59 -0400
X-Greylist: delayed 1794 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2013 08:02:59 EDT
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id DC962CE430
	for <git@vger.kernel.org>; Wed, 17 Jul 2013 13:33:03 +0200 (CEST)
Received: from [127.0.0.1] (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 52A1713004B;
	Wed, 17 Jul 2013 13:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACsJy8BcEfc33HNxQB+_msbkbcxFfqg1xOpeRxNGL_cUqruE0w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230611>

On Mon, Jul 15, 2013 at 07:25:19PM +0700, Duy Nguyen wrote:
>
> I noticed that "quiet" and "agent" capabilities were missing in
> protocol-capabilitities.txt. I have a rough idea what they do, but I
> think it's best to be documented by the authors. Maybe you have some
> time to make a patch?

Hi Duy,

I am sorry to disappoint, but if I had time to work on Git, I'd rather
be writing code. I have some great ideas if you are interested. :-P

Besides, I barely even remember that it was me who implemented the
"quiet" capability. In order to write documentation for it, I would have
to research the implementation as much as anyone.

Cheers,
Clemens
