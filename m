From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log: decorate detached HEAD differently
Date: Fri, 06 Mar 2015 17:20:34 +0100
Message-ID: <54F9D3D2.2070300@drmicha.warpmail.net>
References: <CAPc5daWz-Xa7q6f9RzgTP4has8DcCG4QgK7SMGNbH6KGnEyr2Q@mail.gmail.com> <015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Julien Cretel <j.cretel@umail.ucc.ie>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 17:20:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTuzU-0005iI-11
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 17:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbbCFQUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 11:20:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40554 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750810AbbCFQUg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 11:20:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1B01920B26
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 11:20:35 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 06 Mar 2015 11:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=to2SgzJj7ubPbYGai0ey0F
	Qnw+U=; b=QE2dTQcLWtsnkmJc3oiOQ52kXwecr65Dpu2DPl5fcqXGjMQMqY5l6X
	3T5GFxBXZaoQg2blHNhzi05CzFREqTe57JhM87V4GWvT0RjLSYa45VrxsLA7E+LZ
	ooRK5BhPJfzJthFObXHOegKG18m8JhSpuHPmh3B0bEwBa2JeyuioY=
X-Sasl-enc: P0HjwrEsOcVhzil2+Zx/IX5N1NqsPrg+n3BOHgP84axa 1425658835
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 94BFD680179;
	Fri,  6 Mar 2015 11:20:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <015d6992d2c2165045117f763d9ce3131979c2db.1425658434.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264937>

Michael J Gruber venit, vidit, dixit 06.03.2015 17:15:
... and maybe the patch title should be different for v2, too:

log: decorate non-detached HEAD differently

Not my day today it seems, but this is my last patch for today.

Michael
