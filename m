From: Srirang Doddihal <om.brahmana@gmail.com>
Subject: Re: Git repo on a machine with zero commits is ahead of remote by 103
 commits.. !
Date: Wed, 26 Jan 2011 04:39:36 +0530
Message-ID: <AANLkTim32q=M1fiEhRf=oxg_U9+Liz8vzdfERJTt0QbQ@mail.gmail.com>
References: <AANLkTikj06sjTbNd8afk9cY2=_Hy+kT+J1NCjR-fKP5J@mail.gmail.com>
	<AANLkTinC7yvHJj_onRRWBYaZ23Pvs0JB2DJT44Jy-JLG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 26 00:09:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phs19-0006bY-Tt
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 00:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab1AYXJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 18:09:38 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50901 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab1AYXJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 18:09:37 -0500
Received: by iwn9 with SMTP id 9so323778iwn.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 15:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2ocOoOe2semRIiOgkCDdhhxeXFyDm9dgIfTjSwKIoAc=;
        b=V7ltO8KOploDieArZ1rSXR4GncaHcmCZL+m2fwSG2WiwSmhLoLdT2NUVQJXUdsQAmL
         w/6Q5s4jYdw7CeFNRZicwowm0DXzOkLkihtx3TD0jkDFfoa4E0bPOwqVXWn9RaDOXRX0
         ygKDfey5iheBkalFBnE340qqmjGfkuDB21HTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Lt5huz8NMhOl88fZaTEiBDq7eKo1ah1FlatVqykF8w4+bZ6l4tyXN9czejflZhRT+F
         fn6YwubkldjqSqKEjW+74l7FX6Fm5lnacA4Ayp041kdCVyLiuMaKiLED2KlAOXnS0DO+
         IqjUfzn4/7c5u95gN/MHsrbZRVm+KCbi7qcfQ=
Received: by 10.231.35.131 with SMTP id p3mr7277018ibd.87.1295996976940; Tue,
 25 Jan 2011 15:09:36 -0800 (PST)
Received: by 10.231.206.77 with HTTP; Tue, 25 Jan 2011 15:09:36 -0800 (PST)
In-Reply-To: <AANLkTinC7yvHJj_onRRWBYaZ23Pvs0JB2DJT44Jy-JLG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165486>

Thank you  Jay and Johannes. A 'git pull' solved the problem and I now
understand git a little better. :)

-- 
Regards,
Srirang G Doddihal
Brahmana.

The LIGHT shows the way.
The WISE see it.
The BRAVE walk it.
The PERSISTENT endure and complete it.

I want to do it all ALONE.
