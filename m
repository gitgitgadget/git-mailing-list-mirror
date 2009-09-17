From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: git workflow for fully distributed mini-teams
Date: Thu, 17 Sep 2009 18:08:20 +0530
Message-ID: <f46c52560909170538q4d316d00jcccad8ec9f563574@mail.gmail.com>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
	 <20090916164356.GB24893@vidovic>
	 <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>
	 <4AB1E514.9030501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 14:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGFo-0002dG-3X
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 14:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbZIQMiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 08:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbZIQMiS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 08:38:18 -0400
Received: from mail-pz0-f190.google.com ([209.85.222.190]:34723 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbZIQMiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 08:38:17 -0400
Received: by pzk28 with SMTP id 28so1277922pzk.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=qv6UfGBF+WNjqnkIfKRSTvdCoRNnMwHSbBpYi8PTPLA=;
        b=l63c8VWhm3YAXiXipKWBnNPpiIi3O1YzIXjMBsu0XeociCpbJlrGazi435qRXDgkHg
         GUqTZZssxu+cTulKoH2LVV957Q8FUW9/JbbIY8D31oh79noXKGIqJdf5Ko1dZNXv1VqC
         FnhvQ+qazQ0iCUzrf7HvxQdsOYksbHrxp30AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=bNFRcBjlpT2FVQw4jFhbT1flnD9i6AatevmlazC3zf4U+k/BR+OBHZ74WHvaeFKhYY
         tZCIRzdbJis8hnVmiX8/x41tPdA9xDi4UlYjaVV5FoSAfDWsPmgEnolOStbU6RU2VMvc
         csxZpuWvkZ9Zwmechq8R4UXx4P5V8hnp5SI98=
Received: by 10.114.116.12 with SMTP id o12mr18550634wac.83.1253191100064; 
	Thu, 17 Sep 2009 05:38:20 -0700 (PDT)
In-Reply-To: <4AB1E514.9030501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128749>

On Thu, Sep 17, 2009 at 12:58 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I think the most important thing would be that you send bundles around,
> not patches, so that you all can work with and talk about unique object names.
>
> -- Hannes

Thats what we need -- thanks a  'bundle'!
