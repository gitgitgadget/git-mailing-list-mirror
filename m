From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push default behaviour?
Date: Tue, 13 Mar 2012 16:18:31 +0100
Message-ID: <201203131618.33072.jnareb@gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com> <m3ipidzuxp.fsf@localhost.localdomain> <7vk42t7ngp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos Martin Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:18:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7TUq-0005R8-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 16:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813Ab2CMPSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 11:18:40 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59223 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab2CMPSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 11:18:39 -0400
Received: by wibhj6 with SMTP id hj6so5606893wib.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=64be5cZSHiZJd9ow/VyDI4i9fe6A5FSBTvAJy6inkiQ=;
        b=ms3eizNKRirJBbdIZUx5+MIsoMcRK622HigQpSBQmt/U4EfN+qtbUPZZJE8ULNyyom
         qC3KIHuZmIDwVdO80ZKZtF8dG18ayJIJbJQ4JzevG2fiv+BUSdkklSBvTUqlABQ0bD1m
         PNZUujyED3aTo9c474pts/4IpoBUR4me8iGJmntoRhpiN2yxUpO4btZqs1GfrEUvAFOR
         Dqs4AiCSorodRQSNENsqEeCBkXZ+DCmF4/KaKPvsJNuAwEXgp0idhi5lUlzLjgxZOJ7x
         FJvxjxxdusoaNqD3bXDSilcWWiGoZiDQoraUU63j6PzeZNiUlzBXqWFKRQCVnbTq3q/h
         DA6g==
Received: by 10.180.19.37 with SMTP id b5mr8395080wie.9.1331651918156;
        Tue, 13 Mar 2012 08:18:38 -0700 (PDT)
Received: from [192.168.1.13] (abwr197.neoplus.adsl.tpnet.pl. [83.8.241.197])
        by mx.google.com with ESMTPS id ff2sm3416702wib.9.2012.03.13.08.18.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 08:18:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk42t7ngp.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193032>

On Fri, 9 Mar 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > There are other places where we can send such message beside git
> > mailing list and LKML: There is Junio's "Git Blame" blog, there is Git
> > page on Google+; we can ask for such annoncement to be posted also
> > on GitHub Blog...
> 
> And you are saying who will do all of the above?

I would certainly not be announcing this message on yours "Git Blame"
blog, and you usually accompany new post on blog with announcement on G+
(I don't remember if via "Git" page or via your own personal Google+
page).

I can go round git hosting sites asking to post announcements, similarly
to what I do during annual "Git User's Survey".
-- 
Jakub Narebski
Poland
