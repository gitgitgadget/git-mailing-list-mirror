From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 0/6] Various contrib/ updates
Date: Mon, 20 Aug 2007 18:24:22 +0100
Message-ID: <b0943d9e0708201024m2961599fpde58e215ef0f454c@mail.gmail.com>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 19:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INAzN-0003O3-Vp
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 19:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013AbXHTRY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 13:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbXHTRYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 13:24:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:2429 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbXHTRYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 13:24:24 -0400
Received: by nf-out-0910.google.com with SMTP id g13so685889nfb
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 10:24:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IelrHelAkOZDDCdLPOu9z6MXCnNfQKWWyVxRfFwK4O3ADTQkdvvT8yZRWSVWWskL+Sh6HKOZDKrc1SkocqXtG7omiq7ZIl4Qbd7HYIi80dJEKGiqg4dI7Mhl3E6azy3w33+tObGiNBnJTFLbjODG/RMC51ggsZcTkcUv4V38xgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cwdbb+C+sL1ulW/VlKS+ZnuPUby4mk4OauC12CuR/2RIQIYKBpZWXaejzQKdxcyjf+7QfBJqF1/1zH7V3yL4sujH12tJZf85EBDFysryxvMuXvIYmyaQ0/HOE0dKK68bsHb4yYIhNp/HJgbACZyFXT5M3rMTJ6GNuc9syhuvsCs=
Received: by 10.78.140.16 with SMTP id n16mr2126910hud.1187630662255;
        Mon, 20 Aug 2007 10:24:22 -0700 (PDT)
Received: by 10.78.151.20 with HTTP; Mon, 20 Aug 2007 10:24:22 -0700 (PDT)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56225>

On 02/08/07, Yann Dirson <ydirson@altern.org> wrote:
> This series, asside from small fixes, enhance the bash completion to
> be aware of file status (notably, makes it much more comfortable to
> refresh only selective files), and introduces 2 new contrib scripts:

Thanks.

> I already made heavy use of the scripts in the last days, and I rate
> them as good candidates for 0.13.1.

Should we keep 0.13.1 a bug-fix release only? I.e. not adding the new
contrib scripts.

-- 
Catalin
