From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 INTRO] I hope this will do it!
Date: Mon, 13 Apr 2009 13:45:20 -0500
Message-ID: <b4087cc50904131145g4fa262e7g7ecdf8d7f8e86a9c@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:47:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtRBI-0000Sh-Ah
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbZDMSpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 14:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZDMSpW
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:45:22 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:54423 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZDMSpW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 14:45:22 -0400
Received: by qyk16 with SMTP id 16so4453429qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=XP4HJDCCkWu6RC29708oarir/Bw7MSnrBqnbsPBB4Gs=;
        b=HRcKWP7MznF+b8Evpn64YOECB0mLIIjufAvV0kqcx4WbDi88WK2fL4rSszrDagnT5z
         LFzuxQn9RS6suwYZvmSG/cY5AlHyF6zxuO1/du2xIQR6Ji6QTrOadjOzcfoME7Iz+Y7Q
         wpbgiu8MIJiceA34jBbxvInghlCCeMCNddvLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=R7A6Hqd9Ux4gdZZX5kv3WrSQnHgeQYvTh151YEwS8XAqgo2DsgE8jjbu341Ii68nhq
         9aWoL4WMuFGn+JOZE2C9pKOgvDV3yrWmd3AcKak3fW/eqZ5Uo7iHWho9XLkQLlfNBIMd
         CpSQ5AsStIPrwnu2BM9z6tEZqc7dYFfXeLpuc=
Received: by 10.224.11.18 with SMTP id r18mr6501736qar.63.1239648320540; Mon, 
	13 Apr 2009 11:45:20 -0700 (PDT)
In-Reply-To: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116475>

On Mon, Apr 13, 2009 at 13:23, Michael Witten <mfwitten@gmail.com> wrot=
e:
> =A0Docs: send-email: Remove superfluous information in CONFIGURATION
> =A0 =A0* Remove comment block?
>
> =A0Docs: send-email: Put options back into alphabetical order
> =A0 =A0* Remove comment block?

s/?//

> =A0 =A0[PATCH RFC3 12/13] send-email: --compose takes optional argume=
nt to existing file

This would be better: "send-email: --compose takes optional path"
