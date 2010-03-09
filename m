From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git interix support
Date: Tue, 9 Mar 2010 12:28:52 +0100
Message-ID: <40aa078e1003090328o161675f1tbc33b8740801b6a@mail.gmail.com>
References: <4B962456.20600@salomon.at>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Markus Duft <markus.duft@salomon.at>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:44:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyY5-0001Do-Ts
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab0CIL2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 06:28:55 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42771 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab0CIL2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 06:28:53 -0500
Received: by wya21 with SMTP id 21so3738877wya.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 03:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ss8JDRmX3AoghId3AqTASpkVh6m0aZUrVIxGH43HPqY=;
        b=pQEMMFjEdrJAOrTo2il9zOvQgTODx5ins++T4yV3R/PY1FYo11aW77DiNyAR+0G18Q
         odccQsXYkrGKO2P+8xGkJXlq9IJ90ZhqVbGEKnsEI4iOnI0bKwb6wLRlBgcJzRf/AITK
         DjBNnvF53yR7B/zInDfnpRYLHBEm7h5EQroc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=pG7JbWNwDke8wV0tBpHNsvLRlAxeZGBlxL33WTNgajZVJ22QlEb2bbxRFQBkNFZhoF
         2vknp+mNrp8BdW6prjuhmz1zyChWZIfgnnKFDwPtNWCUQuNXv9NQ4DxZQrk0RWVFHsaI
         5EC7SUCDwB+5rVoXCZHjzy41wGveftMnPU0EA=
Received: by 10.216.90.130 with SMTP id e2mr2519045wef.210.1268134132239; Tue, 
	09 Mar 2010 03:28:52 -0800 (PST)
In-Reply-To: <4B962456.20600@salomon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141825>

On Tue, Mar 9, 2010 at 11:35 AM, Markus Duft <markus.duft@salomon.at> wrote:
> any comments on the patch?

I find it a bit odd to submit a patch against the Git source code that
hasn't been produced by Git, but manual diff'ing of different source
trees...

-- 
Erik "kusma" Faye-Lund
