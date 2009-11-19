From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Thu, 19 Nov 2009 13:11:47 +0900
Message-ID: <20091119131147.6117@nanako3.lavabit.com>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
	<200911151807.15726.trast@student.ethz.ch>
	<4B033D8F.1080309@fastmail.fm>
	<200911181559.02873.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Raman Gupta <rocketraman@fastmail.fm>, <git@vger.kernel.org>,
	<skillzero@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 05:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAyQi-0001Q8-7e
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 05:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbZKSEPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 23:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbZKSEPW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 23:15:22 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60419 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434AbZKSEPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 23:15:21 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4ACAC11B870;
	Wed, 18 Nov 2009 22:15:28 -0600 (CST)
Received: from 4150.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id DL46S79EZ72R; Wed, 18 Nov 2009 22:15:28 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Xk3FqglIJqqoUOAQR73flbqug5uFWRgsg0sB+i1SRzsTRT1XketlIkvPPIDZg20vYJ+YJ3y51V7q688g3dw/LMfjIZK9b8+bg7txGs8KD/yyWMk0RV0dFp21/LkzFWVR860goSfbB28UASNCo+e61fkJqEdIHpiLxaBhATc8rj0=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200911181559.02873.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133211>

Quoting Thomas Rast <trast@student.ethz.ch> writes:

> FWIW, you can add my
>
>   Acked-by: Thomas Rast <trast@student.ethz.ch>
>
> to the final (squashed) patch.

Junio, please also add my

   Acked-by: Nanako Shiraishi <nanako3@lavabit.com>

My changes were intended to be squashed into the final single patch, too.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
