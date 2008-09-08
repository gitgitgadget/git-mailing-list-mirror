From: "Marcello Henrique" <faraohh@gmail.com>
Subject: Change checkout remotely.
Date: Mon, 8 Sep 2008 12:42:22 -0300
Message-ID: <f5cc88f60809080842l34760997r4b821a79e7727d91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 17:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcitm-0003Xe-Gi
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbYIHPmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbYIHPmZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:42:25 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:38987 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbYIHPmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 11:42:24 -0400
Received: by gv-out-0910.google.com with SMTP id e6so252678gvc.37
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=z/65tjOuHZ2qT1Kqrb9FH/1QvPfckYL5al2dKTLp1Rg=;
        b=ayUB39oKj+yXkN8Pyv1RuZ4NiXLXZ9E1m3QUPzb5BxEretIK64Nfl/HkP89MpBEMw2
         4XqSfjaigzbfq9nioTWekzUeyYyZ/NmQDOK89g6A6HkwJMN9Iqxrjn0Ng1Y14ou4YMVT
         nPy2onXwsEhVZEjMz1Tk/30svdGdBHcBqDm3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=j5Qmz8I0sKnao6y1hw/xQpYgdB9Twncm1NN/HUFepcaY97Xpp4C8QamPqA+b/KerxX
         sug65LhTqHVAX5gr6vdlJHH2HrxlMLefwzcVqDpUt8yRYMeovEkxZfw0dg0c0ho1QpM4
         kPneEC0XZxfkI7BfOZWUNCqxbUd0WvuxJzwEU=
Received: by 10.210.81.10 with SMTP id e10mr18988559ebb.44.1220888543011;
        Mon, 08 Sep 2008 08:42:23 -0700 (PDT)
Received: by 10.210.87.5 with HTTP; Mon, 8 Sep 2008 08:42:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95262>

Hello,

Is it possible change checkout another work tree remotely and refresh a=
ll files?

=46or example: git remote other checkout other-branch-x

Thanks!
--
Marcello Henrique
Associa=E7=E3o Software Livre de Goi=E1s (www.aslgo.org.br)
Cercomp - UFG (www.cercomp.ufg.br)
