From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Libgit2, Summer of Code is over
Date: Tue, 17 Aug 2010 14:38:04 +1000
Message-ID: <AANLkTikRUdwcFX6PQRZNDfGXM049Ebyz8d8pF+Bz-AxC@mail.gmail.com>
References: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 06:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlDwE-00023t-SD
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 06:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab0HQEiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 00:38:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47265 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab0HQEiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 00:38:06 -0400
Received: by wwi17 with SMTP id 17so527460wwi.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 21:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eiYzWcv/bSUKSMP09zX74yQSOD6KwQA4KMBAC8nidUE=;
        b=BTE+Eu+UO0fjOQIijk0zZhGAROLpPW6bQ9Y0Zht0BOagzZrXqW2qcIqNS/CfSmBLwG
         3o+IQWn01TMJouZ0QMi8LHjIrg/yv4+LB+PcjbXnX6CxW1x/Nc8QRQveXSvnnKJqP/jn
         Wc+cVDvr9kS1i9aERWN/TK2ujo9+E8Ucp9HDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=a5j7k9WQNdn+D245Oor0+qCsWPAlENhnlDqBye/9tFqt9BH/Ow+YFhG742FQ5s0dLf
         j0jUONrV0RWpyecxLVQvwVwn30MYY6Rg5FIO5rlA27suMpjXxkiANWQvwYQfD0XyVafe
         qsBvHwYfLG8RsC7frcutniGuyBUDiUYYIuEBU=
Received: by 10.216.186.70 with SMTP id v48mr5211010wem.64.1282019884564; Mon,
 16 Aug 2010 21:38:04 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Mon, 16 Aug 2010 21:38:04 -0700 (PDT)
In-Reply-To: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153696>

On Tue, Aug 17, 2010 at 5:46 AM, Vicent Marti <tanoku@gmail.com> wrote:
> After the Summer of Code, here's an overview of what has been accomplished:
> ...
> * Finished implementing the reading of objects from pack files

Yay. I can now go back and finish my git fuse module. Will check
libgit2 out soon.
-- 
Duy
