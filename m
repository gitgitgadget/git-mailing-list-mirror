From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 20:58:59 -0400
Message-ID: <76718490903111758l4e4bd29et379e975deb8e99bd@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <gp9jp7$uc3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 02:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhZHt-0008Hv-1i
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 02:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbZCLA7E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 20:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbZCLA7D
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 20:59:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:39700 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289AbZCLA7B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 20:59:01 -0400
Received: by rv-out-0506.google.com with SMTP id g37so266560rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 17:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TAbcgZhJ5ZvFQzMX6jjndScD6tc8/DI8aVQ7pa6OkZ0=;
        b=ZzSDUq0YN5sv6lW3ZmGcy/T2DpFnok1+TF2E8e/n5U3oTsGPYBC71HX+yVTRHMcwwB
         bzCMrq3tTP+AuKHWrYtc1qRciwSgd5b838Ym0fsasl2uwly0YEXWrKYTSW7VK8tMHNac
         dyut/uU37VgI+tr1UrlIZV/g69kDABDzmUeiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZkJ5BZFyhLO719SSCz3Yolw8kS5YS/dk6Qwst0NU8/Ah0uHSBEFanZAJa2j5IFI0ac
         iQNsgfXd/bH1F0VksBj9Rpc2EgIalwMjngx1N7YoUjWmrGc2CCntr9EQhBx4ldQpfJd7
         wqvEifnnGldLAxftqxFjN9AaFCvNkiiSFEsxk=
Received: by 10.141.2.18 with SMTP id e18mr40081rvi.140.1236819539363; Wed, 11 
	Mar 2009 17:58:59 -0700 (PDT)
In-Reply-To: <gp9jp7$uc3$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112993>

On Wed, Mar 11, 2009 at 8:08 PM, John M. Dlugosz
<ngnr63q02@sneakemail.com> wrote:
> On a related note, what exactly does "tracking" mean? =C2=A0I know th=
at I can
> push/pull local names that match up with names on the origin, and tha=
t the
> latter are in the remotes/origin subdirectory. =C2=A0Those are what I=
 think are
> called "remote tracking branches". =C2=A0Or is that just a part of th=
e whole
> story? =C2=A0What is the correct nomenclature?

http://article.gmane.org/gmane.comp.version-control.git/54822/

j.
