From: Trans <transfire@gmail.com>
Subject: clone branching?
Date: Mon, 11 Aug 2008 14:24:23 -0400
Message-ID: <4b6f054f0808111124g58309f64v496ceb250a068985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 20:25:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSc5B-0004Yh-HA
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYHKSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbYHKSY0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:24:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:46639 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYHKSYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:24:25 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1888774fkq.5
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Dvw+b5sW0yL5ra0gKZMyTsCsZzJ//agHJ7V2sE93E9U=;
        b=MqS0A+CBLsm9GmnrVE1yw++56QS0BSAP7uRKj/w/ti/v7XtUX83ygBFMOuWFFVdse5
         1fd05VFqgLnlPOk79+MrZemT1i6Og90gPjB5KgONBFf7X/eDjKXLbRkYEqltnCAhRSjr
         tc7M0OjH7JrhoauVPlYnASumtl0cIqEkj8PlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=nrZ/i6BT4BP/KQ8r5Xhv0+3T23urGFfECJ+3vL8Z9O4oqE6FjsdybsAB+j58v7J+C4
         ri7GCAnsKxGQj99Cd1E8B13YroRbsCwmrnkVXUU4SogQNPESyYf4KZG8qTRle/2is/60
         zBgBk6XdwqaWm6CcLfsyV/tagH2aVGwH2mA38=
Received: by 10.181.20.6 with SMTP id x6mr3998556bki.32.1218479063956;
        Mon, 11 Aug 2008 11:24:23 -0700 (PDT)
Received: by 10.125.142.16 with HTTP; Mon, 11 Aug 2008 11:24:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91968>

Hi,

I'm new to this list and evaluating whether to use Git. On the whole I
really like Git, however, I'm not sure l like the way it handles
branching.

Can Git be effectively used if clone is used for branching, rather
then using the internal branch naming?

Thanks,
T.
