From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 18:35:56 -0700
Message-ID: <20121031013556.GZ15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
 <20121030185914.GI15167@elie.Belkin>
 <20121031005748.GW15167@elie.Belkin>
 <CAMP44s3pZsDa8w46JWmxFt=BdrxDxnB_r1p50p7eOiaVcjNs-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:36:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNE9-0001RE-S3
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553Ab2JaBgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:36:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46428 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab2JaBgB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:36:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so591284pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Gfvk1HaU6rRg4c8Niiz6gqX/Pany3mnDHQV0OYfavLw=;
        b=UObZFzxmMx0386RwpjCTZ8eI2H9rOKeXDURLDpX9Rsw2z1c/5So+RzP0Se+Geefi0S
         diGIOpPfyy1DLuIWqF/edOFKa4UgIjzy5XO34JOxPV2HGaSN1/VX2Tet7FhrU8imphfK
         txUAgK9aEu07fCAZXx5vmTw701G9meg6oCNeF5Bcaubaj11XNWJBWu4C8pKwnW0EHy8X
         jh7nCbbpinmTjpdobqjY9vW5bij+Y0GXnKQiwmHR3/kQ1/MWxHNRm5AQ2eAkVh2S1bkh
         aZiMKxI7vxB2hqF4T8G/bUaZJ6PsgH25GYSr3iQr2kbGzqlWNCODN9l8Mruo8RxTzEyx
         zsjA==
Received: by 10.68.232.201 with SMTP id tq9mr20811602pbc.12.1351647361181;
        Tue, 30 Oct 2012 18:36:01 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id j4sm1267320pax.31.2012.10.30.18.35.59
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 18:36:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3pZsDa8w46JWmxFt=BdrxDxnB_r1p50p7eOiaVcjNs-w@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208780>

Felipe Contreras wrote:

> This might help you, or other people involved in the problem, but not
> anybody else.

Ok, I give up.  Bye.

Sometimes the author of some code and the right person to interact
with the development community by submitting and maintaining it are
not the same person.  Hopefully others more patient than we two can
pick up where we left off.

Thanks,
Jonathan
