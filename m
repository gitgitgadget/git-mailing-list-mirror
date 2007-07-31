From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: git-gui i18n / 0.9.x plans
Date: Tue, 31 Jul 2007 09:38:23 -0400
Message-ID: <1E593130-7BBC-488D-88A5-2E16D68614A6@yahoo.ca>
References: <20070731012804.GZ20052@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 15:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFs2L-0006Bv-KP
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 15:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbXGaNpM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 09:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbXGaNpL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 09:45:11 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:37839 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752337AbXGaNpK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 09:45:10 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2007 09:45:10 EDT
Received: (qmail 60107 invoked from network); 31 Jul 2007 13:38:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=lA247N5WavO+1ZEyk2K6V5yY1OvUQq6y4J4r6q7cApsjL2XwglpDQGslTikIy140SsBa7MI50vEdyPVoV7PceTRgtyX9QdAOnrAIJoe77LnVVyWy/WOCcvCzyqRjJbkUNFAhATuw5w7/fHaxeC7I9GswiEU2FHOlU6FF3DUOACA=  ;
Received: from unknown (HELO ?192.168.3.231?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp109.mail.mud.yahoo.com with SMTP; 31 Jul 2007 13:38:28 -0000
X-YMail-OSG: xmGp9ucVM1lHqSl6N.Tjg_7hYAeZG3dGqvcBMuhbK_bRwxRRS9Q2.NtgiKSo73uDlrZqo9FMFQ--
In-Reply-To: <20070731012804.GZ20052@spearce.org>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54349>


Le 07-07-30 =E0 21:28, Shawn O. Pearce a =E9crit :
>  - UI for cherry-pick/revert
>  - Hunk splitting/selection

It would be nice to use the configured external merge tool (git =20
mergetool) to help here (in my case os-x:opendiff/FileMerge).
Having a visual diff between
- the repository and the index
- the index and the workarea
- the repository and the workarea

Sorry, I can't contribute (never touched tcl/tk), I can only =20
suggest ... and hope for the best.

- jfv
