From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: excluding files from a merge
Date: Sun, 15 Mar 2009 08:47:30 -0400
Message-ID: <76718490903150547o1c791d35r5d71000b481f443b@mail.gmail.com>
References: <loom.20090315T011519-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Jacobs <djacobs7@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 13:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LippI-0004Gg-8s
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 13:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbZCOMrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 08:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbZCOMrd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 08:47:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:61153 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbZCOMrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2009 08:47:32 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1142913rvb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TZdGYtGm/uEDM5m++/dwqJCCiPonam5uP8vcqCBppj4=;
        b=Iyd+0VjLav3NtM8WHlgdTTMk9wDS0cyUQ40KZfRtBiKtF1QuXkOiK93B6repIWuHK9
         66rSQ1XPchRRkIcm/fcf7rvge/3jFSpa+VkZDUm17NkPaNLZWsyywoqulOvFIfJ/Embs
         GFxDNEYy5p2odkUCJ/4ujXG2POagW+4Fo7xO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i4UHvlf7dBQbC0CyMAyB/dyToumambMI/aiTpSBaF6Rxpuzl9yVKZnv/Sm54PrIOlV
         jQmP0sUgHPsDC2WD0q7OjfcRj04QnagX4M5h6E56Nz6ZPqZLK2F3g7Uy9GIF6ka0J85u
         jqmTZFmg49UlVc8IZ8Zu/C45UdwDJ+SuTKOZw=
Received: by 10.141.179.5 with SMTP id g5mr1652491rvp.76.1237121251018; Sun, 
	15 Mar 2009 05:47:31 -0700 (PDT)
In-Reply-To: <loom.20090315T011519-497@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113287>

On Sat, Mar 14, 2009 at 9:23 PM, Daniel Jacobs <djacobs7@gmail.com> wro=
te:
> I would like it if every file was merged, except for files that were =
explictly
> excluded from a merge between these two branches. =C2=A0Is there a go=
od way to do
> this?

Please see http://thread.gmane.org/gmane.comp.version-control.git/11048=
8
(Is there a way to exclude user-specified files or directories from
participating in merges?)

I believe it is the same use case, and Junio provided a very detailed r=
eply.

HTH,

j.
