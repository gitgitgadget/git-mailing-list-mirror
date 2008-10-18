From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: [Q] submitting patches from gmail
Date: Sat, 18 Oct 2008 08:08:47 -0400
Message-ID: <ee2a733e0810180508m466f3ea1i9c63b47177f6e12d@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 14:10:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrAd8-0000Ws-4t
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 14:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbYJRMIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbYJRMIt
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 08:08:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:52655 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYJRMIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 08:08:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so731264fgg.17
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HsIJCAR9t+BWCR55VxGdSaySI5YiMBG73ljq6grU33w=;
        b=Ljtal+7+SJrZ21G0rekZUJZS+Qr3CIuzSB2Cv+ExSScsoD1T6vIJEHJWSsOkmakqTd
         Il4kFs5CMXfL/eNU2vOgQorywG6Egb0reDAkIb5B7009a/zGHWnodwSuzigrSNlWtnE5
         AULJvCq63OlurGXt5TYceh8YHYaVXJTtK/msU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SLVCbcURdZv9ecd+WsSmCKlZLJSgZ//UNfKeK8lQi5pqgbPeahYu2Gp6lxeslKxynF
         O3OlSQXz6vMeH5Fv7/bl9LloerobuRxdaOzaRVSGmTRUyn+qQBglPxG+rwlk6cJVIkam
         3nPgSeWA8E8FHoiz5PUrYJ6AioNzWQnmwD1oU=
Received: by 10.187.221.20 with SMTP id y20mr786355faq.107.1224331727244;
        Sat, 18 Oct 2008 05:08:47 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sat, 18 Oct 2008 05:08:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98540>

Hi Everyone,
I wonder what is the preferred way to submit patches from a gmail account.
Google mail auto wraps long lines and there is no way to change this setting.
Safe way would be to use attachments. Are they allowed on git mailing list?

Thanks,
--Leo--
