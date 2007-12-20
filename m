From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: git commit does not show all added files in subdirectories
Date: Wed, 19 Dec 2007 22:00:24 -0600
Message-ID: <449c10960712192000j192eb38bycf65a638d2d16c57@mail.gmail.com>
References: <449c10960712191947y3125f782t6ce7ec7b25ded30f@mail.gmail.com>
	 <7v4peerpgi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 05:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Caa-000849-AX
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 05:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbXLTEA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 23:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXLTEA0
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 23:00:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:58245 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbXLTEAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 23:00:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2884031rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 20:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xCNHRPu83Yv634B+4WkEoNHY2OqzShuunZxS05oTz4Q=;
        b=DF3/TJstEG9fhjtIZpcHYIPve1H/L3ItbiDd5UHFO7zaGaMwvW8E84so1DWxprax32KSptX19P1yR7W03zz9eLP0sVgaUx37+7LjbPuFdb/U+kBUvQuqPF4rQcusvEEKi3OTYFHSIJYL6TMLifLvh9ChtWwcWTbzwjMBqOyL40A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YopYKA/UKrv/wopEfhULNBZmGUGuNKtAh8cEaUD1vw1d+6ReNB536skl2eyPDqpm9IBO57Lxamt8N29kIjHlU/f9aOEx02vMA20J7j3KP/hGTOJNT2Fa3foCZ4Ah4eYUt3sAoURQbr96xhYWy3j9OPuR4nyb46hV0uvODwqQQm0=
Received: by 10.141.14.14 with SMTP id r14mr6476459rvi.63.1198123224735;
        Wed, 19 Dec 2007 20:00:24 -0800 (PST)
Received: by 10.141.212.3 with HTTP; Wed, 19 Dec 2007 20:00:24 -0800 (PST)
In-Reply-To: <7v4peerpgi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68971>

On Dec 19, 2007 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Should be fixed already by 3eb2a15eb385749fbfe59b4e37fc754416275760
> (builtin-commit: make summary output consistent with status).

Darn, I looked through the log but must have looked right over that.
Thanks for the quick response.

-Dan
