From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v4 0/4] blame: allow blame --reverse --first-parent when
 it makes sense
Date: Mon, 26 Oct 2015 07:31:19 +0200
Message-ID: <20151026053119.GB27615@wheezy.local>
References: <1445837217-4252-1-git-send-email-max@max630.net>
 <1445837217-4252-2-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 06:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqaNW-0004yy-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 06:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbbJZFb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 01:31:26 -0400
Received: from p3plsmtpa11-06.prod.phx3.secureserver.net ([68.178.252.107]:44587
	"EHLO p3plsmtpa11-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbbJZFb0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 01:31:26 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-06.prod.phx3.secureserver.net with 
	id ZhXM1r0015B68XE01hXPFw; Sun, 25 Oct 2015 22:31:25 -0700
Content-Disposition: inline
In-Reply-To: <1445837217-4252-2-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280178>

On Mon, Oct 26, 2015 at 07:26:54AM +0200, Max Kirillov wrote:
> * Change aproach - instead of assuming children content build them explicitly,
>   also accurately verifying that the specified range is along the first-parent chain
> * Fix error message

Sent by mistake, ignore this, please
