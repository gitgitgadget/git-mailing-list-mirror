From: Seth Falcon <seth@userprimary.net>
Subject: Re: [PATCH] Add a --dry-run option to git-svn rebase
Date: Sun, 1 Jun 2008 21:56:39 -0700
Message-ID: <20080602045639.GB647@ziti.local>
References: <87hcctygah.fsf@nav-akl-pcn-343.mitacad.com> <1211254157-41316-1-git-send-email-seth@userprimary.net> <20080530171831.GB76080@ziti.local> <20080601101304.GC16064@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 06:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K327H-0007Jx-TL
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 06:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYFBE4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 00:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbYFBE4s
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 00:56:48 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:18342 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYFBE4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 00:56:47 -0400
Received: by hs-out-0708.google.com with SMTP id 4so619982hsl.5
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 21:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=yhk0pIFgktSUyRBZwyiwCLigkX6LKM/O32kZMP56+wo=;
        b=FeejR4P6/bINQOemuCeWSe4Y30zGouJdzcndYDALwKpYHDCsvla7LvaLR/yGnqmYfYKmZ4sObXHKQJErOPqNqidrjqhve86OQKCTjqVXYPPzWfRfDTLLxkuvXOTqBAgdzKe96fMOtjsorUDsYY3XEWbOIWLrBjojO3Rs2fNPNYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=mtKZTTgrmcaAURgPnFBSA0Fsk35F4mqngU3Z7iXlKujwV4/YjlAaKrKspNLHOKhwK/hE48kImfxAQ8zzvg68TkNYoPHN4fXOjcJJI5gdMccGt0bdyQbzy0XLHdj7AFW37aygGUJN/K/iFge8UklkIeff2KvVJL8p4GuA1ibcz7Y=
Received: by 10.90.54.17 with SMTP id c17mr10750573aga.74.1212382606523;
        Sun, 01 Jun 2008 21:56:46 -0700 (PDT)
Received: from localhost ( [71.197.245.84])
        by mx.google.com with ESMTPS id f60sm11658808pyh.37.2008.06.01.21.56.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 21:56:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080601101304.GC16064@hand.yhbt.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* On 2008-06-01 at 03:13 -0700 Eric Wong wrote:
> This patch looks reasonable to me.
> Acked-by: Eric Wong <normalperson@yhbt.net>

> One minor nit is 'url' not being capitalized in the output.
> Perhaps:

Any of the suggested bike shed colors are fine by me :-) I'll assume
the patch is fine as-is, or will be edited by Junio before being
applied, unless I hear otherwise.


-- 
Seth Falcon | http://userprimary.net/user/
