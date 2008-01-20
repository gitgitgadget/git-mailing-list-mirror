From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Time to flush developer accumulated patches?
Date: Sun, 20 Jan 2008 11:24:53 +0100
Message-ID: <e5bfff550801200224t6a76f67bp5e550476aa1ac9c@mail.gmail.com>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
	 <0B23B7DB-8AB2-4D8D-BE50-917651238353@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 11:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGXMv-0005x5-Fr
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 11:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYATKYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 05:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbYATKYy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 05:24:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:40688 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYATKYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 05:24:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1417241rvb.1
        for <git@vger.kernel.org>; Sun, 20 Jan 2008 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TDJb//dwMNKHydJPcvxhv2I7YUlNm8+xo2Pm3fk3QBM=;
        b=MtnIyH+78DRIqU8S5/cAeluqrpEfqOG5Jh8MI3T9TNO38LOBF3zQZHDbnmmUEjAk6LDUetJrjtpHUqB0x/eGXOAXiyUUX805QwT2okH8a/CoumaNfzPPrqio5/R/Cq6TdM/Wdzwn3nb4akXZ9ZGbwf6rDC2HD9Tt0szJqywyewA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=filN/ThcitDA7gIKx5bTBAmZ0Zxdtc+L73jfjukedFeXFoOTAzJ31nhhFFCg7PA/2SDJLMJiP2zObzIEnoqeQxzro5edKqDvNMLtgI6tkNeo6fRApuMdejrVdIIlCqLScOs7wzfQ9C06x0Sih84ZBn+jUUg2bZBMw11ziEp9J08=
Received: by 10.140.192.9 with SMTP id p9mr3656423rvf.168.1200824693191;
        Sun, 20 Jan 2008 02:24:53 -0800 (PST)
Received: by 10.141.68.21 with HTTP; Sun, 20 Jan 2008 02:24:53 -0800 (PST)
In-Reply-To: <0B23B7DB-8AB2-4D8D-BE50-917651238353@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71170>

On Jan 20, 2008 11:18 AM, Wincent Colaiuta <win@wincent.com> wrote:
>
> We already have two such branches: next and pu.
>

Yes of course, the name of the branch is not the point here, I
purposely choose an unrealistic name 'new_stuff' to underline this,
sorry if it was not clear.
