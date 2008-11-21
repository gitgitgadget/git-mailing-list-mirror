From: Gary Yang <garyyang6@yahoo.com>
Subject: Re: Cannot git pull using http from my git.mycompany.com
Date: Fri, 21 Nov 2008 09:34:49 -0800 (PST)
Message-ID: <670486.28711.qm@web37901.mail.mud.yahoo.com>
References: <ee77f5c20811210043v1f3af6c5l6f5a25c12d697d2d@mail.gmail.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 18:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ZvL-0004dp-HN
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 18:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbYKURev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 12:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbYKURev
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 12:34:51 -0500
Received: from web37901.mail.mud.yahoo.com ([209.191.91.163]:22569 "HELO
	web37901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753607AbYKUReu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2008 12:34:50 -0500
Received: (qmail 28983 invoked by uid 60001); 21 Nov 2008 17:34:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=SvYn5L0GaBiPmfxQZwfI61vz0eaNTndGa8Rwqn2FzU01xHEpK8zoPa+7jw7jPjqFBG5tcjvs6mZSMc1MZ/CCTmmGXlDSGThl127QN/OlBM165QRr3j59qyyHmRpf6qZ3xQZ7B83oL7JADeIvSpIT+1Rym/lMBkx0U83TwGm+tvk=;
X-YMail-OSG: TvikrqwVM1kSUpNdehdyKnk2CDviN03AsrgsKvstgx0ljxLKnLYP3ulESigXo3XvuC_c.WszLriRob1ay1J5SjIqtiHbij7GoJqqRw0r3Q4fsHrpm45bE7GXLMIvPghB0uhzx5yJ.fibu3jZSzT7rylNd2w4wm225_wah5kadM2P8SNQVn6rm90hhTCE
Received: from [76.195.33.70] by web37901.mail.mud.yahoo.com via HTTP; Fri, 21 Nov 2008 09:34:49 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <ee77f5c20811210043v1f3af6c5l6f5a25c12d697d2d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101535>

Yes


--- On Fri, 11/21/08, David Symonds <dsymonds@gmail.com> wrote:

> From: David Symonds <dsymonds@gmail.com>
> Subject: Re: Cannot git pull using http from my git.mycompany.com
> To: garyyang6@yahoo.com
> Cc: git@vger.kernel.org
> Date: Friday, November 21, 2008, 12:43 AM
> On Fri, Nov 21, 2008 at 12:13 PM, Gary Yang
> <garyyang6@yahoo.com> wrote:
> 
> > git pull http://git.mycompany.com/pub/git/u-boot.git
> HEAD
> > fatal:
> http://git.mycompany.com/pub/git/u-boot.git/info/refs not
> found: did you run git update-server-info on the server?
> >
> > Below are related gitweb configs. What did I do wrong?
> 
> As the error message asks, did you run git
> update-server-info on the server?
> 
> 
> Dave.


      
