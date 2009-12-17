From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Transplant branch from another repository
Date: Thu, 17 Dec 2009 16:36:23 +0530
Message-ID: <5195c8760912170306p28b182adrcd1990b9ec6fa2bc@mail.gmail.com>
References: <hf2t2i$l2b$1@xyzzy.farnsworth.org> <E1NFVyv-0000EN-Qx@xyzzy.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 12:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLEC2-0008MO-0v
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 12:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764390AbZLQLGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 06:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764384AbZLQLGo
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 06:06:44 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:56941 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764377AbZLQLGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 06:06:44 -0500
Received: by vws30 with SMTP id 30so604096vws.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=hJpZWIq/rHKMpa2VwpjKoWWQ/BSckP1e30A9LkKs3DI=;
        b=SWmHRkcADfv0klBxqILtbpKYDM7ldXrEdLAtEtCMO4/HNeCnLn9GNXBG3hWuKsvnFo
         E6w/UZjQdC92JXgLMgzlTLwqN6RnDbhaOh/HHlPU/kqaTBhA8VF4YJ4eSNvIfJiF/P9N
         HFaZoeHaVJkmGfnp9MsR+e5oNCLt2Qq/3Yth8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=d65txNGzEPSs19Jxefwub9w2idNtdCjR+XoOKOntBnSYB9XC/MjA4FwgKJ321SGtKg
         hxJikQHIgqlSFZd/+qYeDWPIAAMRtho+mk9HjjaMNvv+skPZnvHybF84CB0hLzWgsw4x
         8B9vVUKbJ0qHa6K+BuHiSMvIw2mJhT1e7dP0w=
Received: by 10.220.65.86 with SMTP id h22mr554188vci.97.1261048003063; Thu, 
	17 Dec 2009 03:06:43 -0800 (PST)
In-Reply-To: <E1NFVyv-0000EN-Qx@xyzzy.farnsworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135366>

On Tue, Dec 1, 2009 at 10:23 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> [...]
> Try "cd B; git fetch A a:b"

Thanks.
-- 
:J
