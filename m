From: "Felipe Oliveira Carvalho" <felipekde@gmail.com>
Subject: Re: [ANNOUNCE] Git homepage change
Date: Mon, 5 Jan 2009 17:16:33 -0300
Message-ID: <a2075f4c0901051216q193057fdrc07e17b580d67150@mail.gmail.com>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com>
	 <20081216114138.GM12856@machine.or.cz>
	 <d411cc4a0901011040h4ab97aag20de54a6e138a4ec@mail.gmail.com>
	 <20090105164001.GA12275@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Scott Chacon" <schacon@gmail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 05 21:18:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJvte-0003ML-2a
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 21:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbZAEUQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbZAEUQe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 15:16:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:22907 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbZAEUQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 15:16:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6997628rvb.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 12:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ewrua19CKoXJwTL5n7afY0gvjfxj29Z0U79ko3ImeIA=;
        b=pyAqraVEOTO7tpZyQBgrU7vgddANwH3NRLbcSwzSq8NfDGTsspuN+zQW7D1NkiYk3T
         1APWmt6TXSFR0XkyLUv99InB2c5V+3wlnjVz3Qilzt91mChINthOxWFmDHtIrl5VMdYj
         0szXrJ2k+lapQosKmiuna5HBq/v7so1gJIfrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nnN2Q2f8qOO5Q8IApE6TKyyOT/2SMET+SauViLlA4Z3owtwba9qnpMKm9ulYIvtvMW
         4VCrvQ2jcUCTvrXQ9kvo0K3sevoYd7HkLYPgQzd1WEaHzC+oNZ9jTQH05JJvnPFWczwW
         m8kQHcpJzUCy9tM4lIB41OdwzAzEpi5eQlfXc=
Received: by 10.141.153.16 with SMTP id f16mr10519041rvo.283.1231186593238;
        Mon, 05 Jan 2009 12:16:33 -0800 (PST)
Received: by 10.141.169.1 with HTTP; Mon, 5 Jan 2009 12:16:33 -0800 (PST)
In-Reply-To: <20090105164001.GA12275@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104597>

On the footer we have:
"Source for this website was forked from Petr Baudis's git.or.cz"

The link git.or.cz should be changed to git.or.cz/index.html to avoid
confusion for newcomers.

git-scm.com is a very good page for "git quick start".

--
Felipe
