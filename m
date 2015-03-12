From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 08:45:11 +0100
Message-ID: <20150312074511.GB12418@paksenarrion.iveqy.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net>
 <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
 <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com>
 <xmqqd24g6uf1.fsf@gitster.dls.corp.google.com>
 <CACsJy8D38Lx5zvpOGPvnYVNXh4EYbF+rLL8kwb9pwP7EqCqfxQ@mail.gmail.com>
 <xmqqbnjy4y0t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVxv1-0004RB-BT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 08:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbbCLHw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 03:52:29 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34676 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbbCLHpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 03:45:15 -0400
Received: by labgq15 with SMTP id gq15so13975951lab.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YS9mNBEf1AVLPF0uqNYdduexKqB2uIlBOUroKqrVxIY=;
        b=enGFnvzmV+PTR/V6RLRn1GUzD3jj+Z9qJ6LGA/OY6+FZoJQXAzRQm4UpxKtTrjprIT
         xOmIdpAD3a7rKQBumfKiTrys0d95GbbnyVvF/5OtBLllQJA+WywP7a0T5Zc19tii0b7f
         mgwWrC5pqaRpYfbQU/BXkR/l0BGTKpr0jOSNvAD6f6LFSPPxhyMn26b+vbcOQBNMgAOC
         ME2S5Wktgddx8dnxNcqQtmXIKgYKthHHa0UNgRDE05Qapc0hfvGhbOeJYi+3T+fO7Zxo
         zWWpIlCDJDky6BavfCVhvyzzONtf2kBvOJtH095VNETizY30sCGinbwrrDa2wyqXt1+P
         yjKQ==
X-Received: by 10.152.116.65 with SMTP id ju1mr17703974lab.32.1426146313625;
        Thu, 12 Mar 2015 00:45:13 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id n9sm1163218lbp.0.2015.03.12.00.45.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2015 00:45:12 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1YVxnr-0004XN-Rg; Thu, 12 Mar 2015 08:45:11 +0100
Content-Disposition: inline
In-Reply-To: <xmqqbnjy4y0t.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265354>

On Wed, Mar 11, 2015 at 09:53:22PM -0700, Junio C Hamano wrote:
> I'd first suggest to employ "icase" to unify *-By and *-by.  Perhaps
> we would want a recommended list somewhere in SubmittingPatches to
> discourage people from getting too creative?

There's already such list in SubmittingPatches, so there's already quite
a few to choose from:

Also notice that a real name is used in the Signed-off-by: line. Please
don't hide your real name.

If you like, you can put extra tags at the end:

1. "Reported-by:" is used to credit someone who found the bug that
	the patch attempts to fix.
2. "Acked-by:" says that the person who is more familiar with the
	area the patch attempts to modify liked the patch.
3. "Reviewed-by:", unlike the other tags, can only be offered by
	the reviewer and means that she is completely satisfied that the
	patch is ready for application.  It is usually offered only after
	a detailed review.
4. "Tested-by:" is used to indicate that the person
	applied the patch and found it to have the desired effect.

You can also create your own tag or use one that's in common usage such as
"Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
