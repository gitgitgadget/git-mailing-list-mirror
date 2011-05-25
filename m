From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] Remove a dead assignment
Date: Wed, 25 May 2011 19:18:57 +0200
Message-ID: <4DDD3A01.6040407@elegosoft.com>
References: <20110524210758.GH16052@localhost> <20110524224525.GI16052@localhost> <vpqfwo3ush3.fsf@bauges.imag.fr> <20110525150631.GA29161@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Wilson <cwilson@vigilantsw.com>
X-From: git-owner@vger.kernel.org Wed May 25 19:19:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHjp-0001x4-Un
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab1EYRTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 13:19:08 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:51933 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab1EYRTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:19:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id A31B8DE783;
	Wed, 25 May 2011 19:19:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A+etEiyqYDqR; Wed, 25 May 2011 19:19:01 +0200 (CEST)
Received: from [87.77.85.195] (z55c3.pia.fu-berlin.de [87.77.85.195])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CCFA7DE771;
	Wed, 25 May 2011 19:19:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110503 Thunderbird/3.1.10
In-Reply-To: <20110525150631.GA29161@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174433>

There already is a patch on its way:

http://article.gmane.org/gmane.comp.version-control.git/174378
