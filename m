From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] rebase -i: print the editor name if it fails to launch
Date: Sun, 20 Dec 2009 09:40:14 +0100
Message-ID: <6672d0160912200040s6fbf5833q252b40bef4ea42b0@mail.gmail.com>
References: <4B2DE132.1080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 09:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMHKw-0006NR-Mr
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 09:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbZLTIkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 03:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZLTIkR
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 03:40:17 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36061 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZLTIkQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 03:40:16 -0500
Received: by bwz27 with SMTP id 27so2935190bwz.21
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 00:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=08gSQVxhiGabP/K8+/2EGm/nvIVp5UHW3XrP4AEebVQ=;
        b=uBBF3PyFAE+tr8qJmS9D0x9CXedPG9SPbmk8h1I45BWuw7RI1pHJbegjdINir5Vr8A
         RfjB1pP8KR19tdctmeprvqOoZ1MGol4cDUpTgPXL17kq3tR/yZHltgEAdiQvlieG2DK4
         7nxlcKwDPd4MhFRQ80oeAyEApoS/oCQLiEIps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E1ip9qhzNuQnXZ6EbfAiGVmUfX8i1vxqaw7FnMJE0EkiuowlyQSsI5HT5ltebCrKdv
         uv0jOZ/ve2zzNriRcYs24tvBkFdg5W1poAxxBqpUJw13PvbrIxpEn5f8udy7lsVfew7H
         DmiyDMRiFtJqU2uGuey0Xm8h55AvsfYrrunx8=
Received: by 10.204.29.22 with SMTP id o22mr3875718bkc.78.1261298414497; Sun, 
	20 Dec 2009 00:40:14 -0800 (PST)
In-Reply-To: <4B2DE132.1080700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135526>

Oops, I seem to have hit the Send button too early. Please ignore the
first email that stops in mid sentence.
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
