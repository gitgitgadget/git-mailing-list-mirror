From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: convert "glossary" and "core-tutorial" to man pages
Date: Sun, 4 May 2008 14:13:27 +0200
Message-ID: <200805041413.28464.jnareb@gmail.com>
References: <20080504122157.ca98c75d.chriscool@tuxfamily.org> <200805041313.03499.jnareb@gmail.com> <1F80B8CA-7FF5-4455-857A-E078C79DB479@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun May 04 14:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsd71-0007uP-6M
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 14:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbYEDMNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 08:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbYEDMNm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 08:13:42 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:14698 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbYEDMNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 08:13:42 -0400
Received: by fk-out-0910.google.com with SMTP id 18so275463fkq.5
        for <git@vger.kernel.org>; Sun, 04 May 2008 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=CZ4s0Usg6HXbFNb7M1ry/Ll/17l4fIZgPI5oE4aBRfg=;
        b=jupVrUxe/dSBg/Vkcgd0kdfuyqEhq1G6aZOlOiAAd7bOnNib5UJJDqoA9GbHkcToB0q3NrSAjQsgJpQwk4gKLiKfYhmYqUxVKeblqXia4/AaxH69cYiXc87fFJJZykrFTRVXeMVUn3fZkgney040BFDYj1+UJdVs/wWfXLMuhao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EbvulBCHdr6QUE126DWX/rHFA3ZWAQnlEGQpC8SPr3z81/stmYUQlzSnfVboAuuQGV5c55hbUzbMeC2pysPSqbV1oqlywJaRTNm8eX47yjRGCw82CFnKX1rhmyZgSdam0AI+0dh40W8xMXg4IEq+36K4vCrd0dgVDOZGE+jhzpE=
Received: by 10.86.78.4 with SMTP id a4mr9445962fgb.17.1209903220100;
        Sun, 04 May 2008 05:13:40 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.224.254])
        by mx.google.com with ESMTPS id e20sm4416495fga.7.2008.05.04.05.13.36
        (version=SSLv3 cipher=OTHER);
        Sun, 04 May 2008 05:13:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1F80B8CA-7FF5-4455-857A-E078C79DB479@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81173>

On Sun, 4 May 2008, Pieter de Bie napisa=B3:
>=20
> On 4 mei 2008, at 13:13, Jakub Narebski wrote:
>>>
>>> core-tutorial.txt -> gitcore-tutorial.txt
>>> glossary.txt      -> gitglossary.txt
>>
>> I like this, although I think that perhaps git-core-tutorial.txt wou=
ld
>> be a better filename.
>=20
> I would change it to just "git-tutorial".

Not possible.  There are two other git tutorials (I think they are
being slowly into "Git User's Manual", user-manual.txt), and this
is core git/plumbing tutorial.  Perhaps git-plumbing-tutorial.txt,
if at that...

BTW. what I'd like to see is to have "Git from bottom up" incorporated
(added to) core-tutorial...

--=20
Jakub Narebski
Poland
