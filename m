From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 20:27:14 +0200
Message-ID: <CAGdFq_h5gimMkwhyOv0PFqVwx4pExL7Zri8Tki_dT5HDtFcBFA@mail.gmail.com>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnxDf-0001wz-GH
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab1HAS14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 14:27:56 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:49448 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1HAS1y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 14:27:54 -0400
Received: by pzk37 with SMTP id 37so11937390pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZyGShVhMsf76yKFelOpyDsA+ANCefseC1VKxeCszGOI=;
        b=ijrpDLLBIh6mhpXnxSLhuJI9I0VmZd+ohy51Po6L03boqYf7ebJpW0RvHXnLErAXfR
         0gFEc/xUnA74ya0u+ykzSh0c0vavqlvAplIhT0Q/3Lk8x1WGnC/grOMJ4+XJHz4tZAi1
         nolE0eNLBiDPq3AsFIQCogQehiSWs5WNgsLDg=
Received: by 10.68.28.106 with SMTP id a10mr9176793pbh.176.1312223274082; Mon,
 01 Aug 2011 11:27:54 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Mon, 1 Aug 2011 11:27:14 -0700 (PDT)
In-Reply-To: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178396>

Heya,

On Mon, Aug 1, 2011 at 20:20, martin f krafft <madduck@madduck.net> wro=
te:
> My intent was to add an extra commit header to select commits as
> a way to store extra information needed to automate the management
> of interdependent branches and patch generation =C3=A0 la TopGit.

Have you had a look at git notes?

--=20
Cheers,

Sverre Rabbelier
