Received: from senderb19.zcsend.net (senderb19.zcsend.net [135.84.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAC123315A
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.84.83.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745018; cv=none; b=j3giz0pVte2gQisaHaV8hPhcyEBQzAOr8Y5jI8+U90YbWY3D+gOeAU7x8ZfV24nKWXyUPxmysy+bOSc3lfGWBcg/xUPMBkmXQsULYxc6mvmpfXiiSnCe1YqtUzThLsXSs5l+PdFyPJFVJwGRsqqJofUrXhRmpfte8G4pFlplA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745018; c=relaxed/simple;
	bh=m5piA4iQixbXHGA5wQJNsR1RAT6kbXI25FwN4drBY3A=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=ttnBqcxZBzIXzIlaHho+4FykzggifE3bVDKVaWrXV77I3a7WNMOZ8T3rgATQ4OTSqRxV5noFJJMYTk3AqHNjR8XQ8lCXTnwpR4I2dAQZZmYTHIma9Bmo3DoTSuADfXJd91O1TbAn4HUM7qLm0cbUv5Yc1pPVPfl+ias/hJmGanA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=investorstrustco.net; spf=pass smtp.mailfrom=mailb10.zgph.zcsend.net; dkim=pass (1024-bit key) header.d=mailb10.zgph.zcsend.net header.i=@mailb10.zgph.zcsend.net header.b=OA50shnO; dkim=pass (1024-bit key) header.d=mailb4.zgpgl.zcsend.net header.i=@mailb4.zgpgl.zcsend.net header.b=Lxonuxrj; arc=none smtp.client-ip=135.84.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=investorstrustco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailb10.zgph.zcsend.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailb10.zgph.zcsend.net header.i=@mailb10.zgph.zcsend.net header.b="OA50shnO";
	dkim=pass (1024-bit key) header.d=mailb4.zgpgl.zcsend.net header.i=@mailb4.zgpgl.zcsend.net header.b="Lxonuxrj"
Received: from 10.75.159.112 by senderb19.zcsend.net
	with SMTP id 174074501560760027; Fri, 28 Feb 2025 04:16:55 -0800
DKIM-Signature: a=rsa-sha256; b=OA50shnOsOV77OsATxUx3o60y/fznBINAoYtHhXn8X0P9xwVPVaCcc6xeJOqJy0M6VYOfPZEO4BOJOdvztO/UN+qgIQs/A8kAxMjW85rVNnSEhRucLJN8OqiJ+U+COY0PwdyUf93bQjtSnRlRzlWy8dFSv6LwCVCN4uat9BBMiE=; c=simple/simple; s=k1; d=mailb10.zgph.zcsend.net; v=1; bh=m5piA4iQixbXHGA5wQJNsR1RAT6kbXI25FwN4drBY3A=; h=date:date:from:from:to:to:message-id:subject:subject:mime-version:content-type:list-unsubscribe:list-unsubscribe:list-unsubscribe-post:x-csa-complaints;
DKIM-Signature: a=rsa-sha256; b=LxonuxrjWf4hMq+yNxXE0ozG/jGypILGqIsm3t5yihl2FVc3ohopydPGSetQGlPXrp6CeHcW3cYRFCopY70Z7XC3azL8MgqY2DM62S3KTMBD1A+U5I1h1pLmujEcVA5OW5/fSZyeQy+MSvszfMzg8DvUv9GHEU/3jBybR18vy7c=; c=simple/simple; s=k1; d=mailb4.zgpgl.zcsend.net; v=1; bh=m5piA4iQixbXHGA5wQJNsR1RAT6kbXI25FwN4drBY3A=; h=date:date:from:from:to:to:message-id:subject:subject:mime-version:content-type:list-unsubscribe:list-unsubscribe:list-unsubscribe-post:x-csa-complaints;
Date: Fri, 28 Feb 2025 04:16:55 -0800 (PST)
From: "Iyke Nicolas" <iyke1@investorstrustco.net>
To: git@vger.kernel.org
Message-ID: <zcb.3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a.113bcf508afcbe1bc.1740745015605@mailb10.zgph.zcsend.net>
Subject: Small/Large business Funding
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-CSA-Complaints: csa-complaints@eco.de
Reply-To: iyke1@investorstrustco.net
Content-Transfer-Encoding: quoted-printable
X-JID: 3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a.113bcf508afca8e11
X-campaignid: zohocampaigns.3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a.zcb.113bcf508afcbe1bc.11699e4c287802e
X-Zoho-RID: zohocampaigns.3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a.zcb.113bcf508afcbe1bc.11699e4c287802e
X-Mailer: Zoho Campaigns
X-Report-Abuse: <Please send a copy of this message along with header to abuse+3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a_zcb_113bcf508afcbe1bc@zohocampaigns.com>, <https://zcmg-get.maillist-manage.com/campaigns/ReportAbuse.zc?od=3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a&rd=113bcf508afcbe1bc&sd=113bcf508afcbb6df&n=11699e4c287802e>

Hello,

    Do you require capital financing or low interest loans to advance your =
business projects or growth strategy?

     We can provide you with the needed investments for your business. Get =
back to me if interested.

    Best regards,


    Iyke Nikolas
    Managing Partner
    Investors Trust




----------------------------------------------------------------------
This email was sent by iyke1@investorstrustco.net to git@vger.kernel.org

Not interested? Unsubscribe - https://zcmg-get.maillist-manage.com/ua/optou=
t?od=3D3z8b0eb2103189386440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a&r=
d=3D113bcf508afcbe1bc&sd=3D113bcf508afcbb6df&n=3D11699e4c287802e

Update profile -  https://zcmg-get.maillist-manage.com/ua/upc?upd=3D113bcf5=
08afcb1c27&r=3D113bcf508afcbe1bc&n=3D11699e4c287802e&od=3D3z8b0eb2103189386=
440ec6ae011d60d223aad5964daf827e7be1c4149f599c84a
  =20



Investors Trust Inc | 5 Yotzonot Dr=20



Our Privacy Policy [  ] and Terms of Use. [  ]=20
