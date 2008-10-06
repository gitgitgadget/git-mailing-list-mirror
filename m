From: "Dilip M" <dilipm79@gmail.com>
Subject: how to restrict commit for a repo
Date: Mon, 6 Oct 2008 17:39:39 +0530
Message-ID: <c94f8e120810060509w5eaa9138m92f1df36c9c36db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 14:11:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmovM-0006oR-C4
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 14:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbYJFMJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 08:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYJFMJl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 08:09:41 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:32857 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbYJFMJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 08:09:40 -0400
Received: by yx-out-2324.google.com with SMTP id 8so407769yxm.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=+7blD29L/xXSahnqunU4zJLmLXdbUrd5tDKPtthuAuM=;
        b=Iv3mOovbk7HYo09VmWI2mmImqVGlnY3MweZYpQtxfJKxpqPdATfP3qjC3Y270msg+D
         WJC08o9jKrETFuDQ74VftoKKT+6Dy6gGeFQJl2LQjWt7QS8mLcTP2FlKhSI1loOtYf75
         xJuOlPjUqqutrHKv4rX5ii3DXV9E+fIHwzN64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=k7nBtTZ6XoichmvbnlmRu5s9P0cGXD0/fmW++WTTPFKG9Iz/hgXSGrNjykLBr3h0s7
         2IMEK1SjDEGYzCu/fwEBPkDpJb54Ae+x0Fs82kiw8qp1P2wgTe9zEO6sxKLXq8CtLrth
         JT/L3LuRGI6jPwmAOuXiiBvOSi9jzT/o63KrI=
Received: by 10.90.71.15 with SMTP id t15mr5670491aga.19.1223294979221;
        Mon, 06 Oct 2008 05:09:39 -0700 (PDT)
Received: by 10.90.52.15 with HTTP; Mon, 6 Oct 2008 05:09:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97578>

Hi all,

I am a new user to GIT. Read few docs in web ..I want to know few things..

If I have a repository, how to prevent push from other repo's into
mine master's? I want to prevent the commits from all developers and
allow only few ppl to commit to masters..

Thanks for sharing the info on this...


-- 
dm
